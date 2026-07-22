# 02 — Logging knowledge: decisions, gotchas, research, plans

Four log types, each with a home, a format, and a skill that maintains it. The unifying rule: **logs are written by the agent as a byproduct of work, never as separate homework.** That's the only way they stay alive on a team.

| What | Where | Format | Maintained by |
|---|---|---|---|
| Decisions | `docs/decisions/NNNN-slug.md` | Mini-ADR, ≤ 25 lines | `/log-decision` — agent proposes, human approves |
| Gotchas / lessons | `docs/gotchas/<domain>.md` | Append-only, 1–3 lines per entry | `/learn` at end of session |
| Research | `docs/research/YYYY-MM-DD-topic.md` | "What I learned" artifact | `/research` |
| Plans | `docs/plans/YYYY-MM-DD-feature.md` | Phased steps + per-phase verification | `/plan` |

## What deliberately has no markdown home

- **Bugs and task status** → your issue tracker (GitHub Issues via `gh`, Linear, or Beads for long-horizon agent work). Knowledge compounds in markdown; work state rots in markdown. Agents left to track status in prose produce hundreds of stale plan files (the failure Beads was built after).
- **History** → git. Good commit messages and PR descriptions are the changelog. A bug earns a gotcha entry only when the fix taught a reusable lesson.
- **Session logs** → skip as a default. Elite teams either auto-generate session insights or don't keep them. If a session's learnings matter, they belong in a gotcha, a decision, or a plan — not a diary.

## Decisions (ADRs)

One short file per decision: context → decision → consequences. Agents actually read these — CLAUDE.md tells them to check `docs/decisions/` before architectural changes, which turns ADRs from documents nobody reads into constraints that get enforced.

The important shift from classic ADR practice: **the agent proposes the ADR when a session makes a decision.** Humans just approve. A decision made in chat and not logged will be silently reversed by a future session that never saw it.

## Gotchas

Entries look like:

> Use `stem` (file path without extension) instead of `slug` in page collection queries — `slug` doesn't exist. (2026-07, hit in PR #142)

Standards:
- **Must trace to a real observed failure or hard-won discovery.** No aspirational entries.
- 1–3 lines. If it needs more, it's a doc the gotcha file links to.
- One file per domain (`frontend.md`, `payments.md`, `infra.md`) so path-scoped loading stays cheap.
- If a tool could enforce it, convert the entry to a hook or lint rule and delete it.

## Research and plan artifacts

Covered in [03 — Workflow](03-workflow.md). The short version: these are the *team-shareable unit of agent work*. A teammate (or a fresh session) picks up a one-page research doc or a phased plan, not a 200k-token conversation. Date-stamp filenames; plans link the research they're based on. They're snapshots, not living docs — it's fine for old ones to go stale; the date says so.

## The compounding loop

The system above is inert without the ritual:

1. Agent makes a mistake → before the session ends, `/learn` files the lesson (gotcha, CLAUDE.md line, or hook).
2. A judgment call gets made → `/log-decision`.
3. Code review catches an agent pattern → the correction goes into CLAUDE.md, ideally automated (Boris Cherny's team tags `@.claude` on PRs and a GitHub Action commits the correction).

Measure it the way Cherny does: your correction rate should visibly drop over weeks. If you're correcting the same thing twice, the first correction didn't get captured.
