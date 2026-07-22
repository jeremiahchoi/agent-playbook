# 08 — The automation ladder

"I want to use Claude normally and have the workflow run in the background" is the right goal — and the top practitioners get there with explicit machinery, not hope. Five rungs, each stronger and costlier than the last. **Climb only when the rung below observably misses.**

## L1 — Proactive skill descriptions (shipped in the plugin)

The description is what the model matches when deciding to self-apply a skill. "Run at the end of any session where…" reads fine in a menu but never fires; "Use PROACTIVELY, without being asked, when…" does. All plugin skills are written this way.

## L2 — Standing CLAUDE.md policy (shipped in the kit)

A few lines of standing orders ("non-trivial work: research → plan before implementing; run verify-app before claiming done"). Advisory, but it stacks with L1 — two independent nudges toward the same behavior.

## L3 — SessionStart bootstrap (shipped in the plugin)

Superpowers' core mechanism, and the reason it feels like Claude "just does it": a SessionStart hook injects the working policy into context at the start of *every* session, including after `/clear`. Ours injects one short paragraph (~60 tokens/session — the price of proactivity) restating the policy and the mandatory-use rule: *if a skill exists for an activity, use it.*

## L4 — Stop hooks: deterministic tripwires

When L1–L3 still miss (e.g., sessions keep ending without a `/learn` pass after obvious mistakes), stop asking nicer and make it mechanical. A Stop hook runs a script when Claude tries to end its turn; exit 2 with a reason forces Claude to keep working:

```json
{
  "hooks": {
    "Stop": [{ "hooks": [{ "type": "command", "command": ".claude/hooks/done-checklist.sh" }] }]
  }
}
```

Rules from the people running these in production:

- **Guard against loops**: read `stop_hook_active` from stdin and exit 0 if set, or the hook re-fires forever (Claude Code force-ends after 8 blocks regardless).
- **Keep it fast**: the hook runs on *every* turn end. A slow check makes every turn feel broken. Cache, or gate on "did this session edit files?" first.
- **Block on evidence, not vibes**: tests exit code, lint, a checklist file — things a script can verify.

## L5 — Composition and event-driven capture

- **Meta-skills** (Boris Cherny's `/go`): one command chains the pipeline — implement the plan → verify-app → code-simplifier → commit → PR. The human types one thing; the discipline is inside the skill.
- **Event-driven capture**: knowledge capture attached to lifecycle events instead of anyone's memory — the `@claude` PR-review GitHub Action committing corrections to CLAUDE.md, scheduled `/babysit`-style PR shepherding, Cognition's auto session insights.

## Diagnosing which rung you need

| Symptom | Rung |
|---|---|
| Skills never fire on their own | L1: rewrite descriptions with explicit triggers |
| Fire sometimes, miss after `/clear` or long sessions | L3: bootstrap re-injects policy every session |
| Fires but skips the *check* under time pressure | L4: Stop hook on the check |
| Everything fires but takes five prompts to sequence | L5: compose a meta-skill |

Superpowers also validates the top of this ladder from the other side: skills themselves get tested like code — run on subagents under pressure scenarios to see if they hold. When a rung of your automation misses, that's a real observed failure: log it in gotchas, then climb.
