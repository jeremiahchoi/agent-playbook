#!/usr/bin/env bash
# SessionStart hook: announce the standing policy, adjusted to whether this
# repo has been adopted (i.e. has a scaffolded verify-app agent).
dir="${CLAUDE_PROJECT_DIR:-$PWD}"
if [ -f "$dir/.claude/agents/verify-app.md" ]; then
  verify="run the verify-app subagent and report its evidence"
else
  verify="verify by actually running or exercising the change and report the evidence (this repo has no verify-app agent yet; /agent-playbook:adopt can scaffold one)"
fi
echo "agent-playbook workflows are active. Standing policy: (1) for any change touching multiple files or an unfamiliar area, use the research skill, then the plan skill, BEFORE writing implementation code; (2) before declaring non-trivial work done, ${verify}; (3) when wrapping up, if you made a mistake, were corrected, or settled a decision, proactively use the learn / log-decision skills (they propose drafts for human approval). If a skill exists for an activity, use it."
