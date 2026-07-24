#!/usr/bin/env bash
# agent-playbook status line: shows that the workflow system is active, plus
# live context usage so you can compact/hand off before quality degrades.
# Enable in .claude/settings.json:
#   "statusLine": { "type": "command", "command": "$CLAUDE_PROJECT_DIR/.claude/statusline.sh" }
set -uo pipefail

input=$(cat)
j() { printf '%s' "$input" | jq -r "$1 // empty" 2>/dev/null; }

model=$(j '.model.display_name')
dir=$(basename "$(j '.workspace.current_dir')" 2>/dev/null)
transcript=$(j '.transcript_path')

# Context usage: prefer a first-class field, else derive from the transcript's
# most recent usage record (input + cache tokens = what the model actually saw).
pct=$(j '.context.percent_used')
if [ -z "$pct" ]; then
  used=$(j '.context.used_tokens')
  if [ -z "$used" ] && [ -n "$transcript" ] && [ -f "$transcript" ]; then
    used=$(tail -n 400 "$transcript" 2>/dev/null | jq -s '
      [ .[] | .message?.usage? // empty
        | (.input_tokens // 0) + (.cache_read_input_tokens // 0)
          + (.cache_creation_input_tokens // 0) ]
      | max // empty' 2>/dev/null)
  fi
  limit=$(j '.context.max_tokens'); limit=${limit:-200000}
  if [ -n "${used:-}" ] && [ "${used:-0}" -gt 0 ] 2>/dev/null; then
    pct=$(( used * 100 / limit ))
  fi
fi

# Thresholds from playbook/09: <50 fine, 50-70 wrap up, >70 act now.
ctx=""
if [ -n "${pct:-}" ]; then
  if   [ "$pct" -ge 70 ]; then ctx=$(printf '\033[31m🔴 ctx %s%% — /compact or /agent-playbook:handoff now\033[0m' "$pct")
  elif [ "$pct" -ge 50 ]; then ctx=$(printf '\033[33m🟡 ctx %s%% — wrap up this thread\033[0m' "$pct")
  else                         ctx=$(printf '\033[32m🟢 ctx %s%%\033[0m' "$pct")
  fi
fi

printf '\033[36m📘 playbook\033[0m │ %s │ %s%s' "${dir:-?}" "${model:-Claude}" "${ctx:+ │ $ctx}"
