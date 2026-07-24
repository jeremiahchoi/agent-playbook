#!/usr/bin/env bash
# agent-playbook status line: shows that the workflow system is active, plus
# live context usage so you can compact/hand off before quality degrades.
# No dependencies beyond python3 (preinstalled on macOS and most Linux).
# Enable in .claude/settings.json:
#   "statusLine": { "type": "command", "command": "$CLAUDE_PROJECT_DIR/.claude/statusline.sh" }
CODE=$(cat <<'PY'
import json, os, sys

try:
    data = json.load(sys.stdin)
except Exception:
    data = {}

def g(path, default=None):
    cur = data
    for k in path.split("."):
        if not isinstance(cur, dict) or k not in cur:
            return default
        cur = cur[k]
    return cur

model = g("model.display_name") or "Claude"
cwd = g("workspace.current_dir") or ""
repo = os.path.basename(cwd) if cwd else "?"

# Installed plugin version, shown as "playbook vX.Y.Z" when discoverable.
ver = ""
home = os.path.expanduser("~")
candidates = []
try:
    inst = json.load(open(os.path.join(home, ".claude/plugins/installed_plugins.json")))
    for entry in inst.get("plugins", {}).get("agent-playbook@agent-playbook", []):
        p = entry.get("installPath")
        if p:
            candidates.append(os.path.join(p, "VERSION"))
except Exception:
    pass
candidates.append(os.path.join(
    home, ".claude/plugins/marketplaces/agent-playbook/plugins/agent-playbook/VERSION"))
for c in candidates:
    try:
        ver = open(c).read().strip()
        if ver:
            break
    except Exception:
        continue
badge = f"📘 playbook v{ver}" if ver else "📘 playbook"

# Context %: first-class field, else derive from used/max, else from the
# transcript's most recent usage record (input + cache = what the model saw).
pct = g("context.percent_used")
if pct is None:
    used = g("context.used_tokens")
    limit = g("context.max_tokens") or 200000
    if used is None:
        tp = g("transcript_path")
        if tp and os.path.isfile(tp):
            best = 0
            try:
                with open(tp, "rb") as f:
                    tail = f.read()[-200000:].decode("utf-8", "ignore")
                for line in tail.splitlines():
                    try:
                        u = json.loads(line).get("message", {}).get("usage", {})
                        t = (u.get("input_tokens", 0) + u.get("cache_read_input_tokens", 0)
                             + u.get("cache_creation_input_tokens", 0))
                        best = max(best, t)
                    except Exception:
                        continue
            except Exception:
                best = 0
            used = best or None
    if used:
        pct = int(used * 100 / limit)

# Thresholds from playbook/09: <50 fine, 50-70 wrap up, >70 act now.
ctx = ""
if isinstance(pct, (int, float)):
    p = int(pct)
    if p >= 70:
        ctx = f" │ \033[31m🔴 ctx {p}% — /compact or /agent-playbook:handoff now\033[0m"
    elif p >= 50:
        ctx = f" │ \033[33m🟡 ctx {p}% — wrap up this thread\033[0m"
    else:
        ctx = f" │ \033[32m🟢 ctx {p}%\033[0m"

print(f"\033[36m{badge}\033[0m │ {repo} │ {model}{ctx}", end="")
PY
)
exec python3 -c "$CODE"
