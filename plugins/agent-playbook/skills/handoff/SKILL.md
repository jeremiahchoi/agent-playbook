---
name: handoff
description: Write a handoff note capturing session state so a fresh session (or teammate) resumes instantly. Use PROACTIVELY before /clear or /compact, when context passes ~70%, and at the end of any session with unfinished work — compaction is lossy, a file is not.
---

# Handoff — make this session's state survive

Announce on its own line: `📘 agent-playbook:handoff — writing session state to .claude/HANDOFF.md`

Write `.claude/HANDOFF.md` (overwrite any previous one — it's a baton, not a log). Keep it under ~40 lines: dense enough to resume from, short enough to actually read.

```markdown
# Handoff — YYYY-MM-DD HH:MM

## Goal
One sentence: what we're trying to accomplish.

## State
Where things actually stand. What works now that didn't before.

## Done
- Concrete completed steps (with file paths)

## Next
1. The immediate next action, specific enough to start cold
2. …

## Files touched
`path/a.ts` — what changed and why
`path/b.py` — …

## Decisions made this session
- Decision + one-line reason (if any are architectural, use log-decision too)

## Open threads / gotchas
- Unresolved bugs, failed approaches already ruled out (so the next session doesn't retry them), commands that must run before things work
```

Rules:

1. **Preserve what compaction loses**: architectural decisions, unresolved bugs, implementation details, exact file paths, and *failed approaches* (knowing what didn't work is worth as much as what did). Drop raw tool output and file contents — those are re-readable.
2. **Write it before you need it.** Called at 70% context or before `/clear`, this is cheap insurance. Called after context is gone, it's already too late.
3. If the work has a plan in `docs/plans/`, update its phase checkboxes instead of duplicating them here, and point at it: *"resuming plan: docs/plans/…md, phase 2 of 4."*
4. Add `.claude/HANDOFF.md` to `.gitignore` unless the team wants handoffs shared (they're session state, not repo knowledge — durable knowledge belongs in gotchas/decisions/plans).
5. After writing, tell the user the note is ready and that they can safely `/clear`, and offer the one-line resume prompt: *"read .claude/HANDOFF.md and continue."*
