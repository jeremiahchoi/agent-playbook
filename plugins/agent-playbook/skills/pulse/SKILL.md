---
name: pulse
description: Scorecard of how much value the agent-playbook system is generating in this repo — knowledge captured, artifacts produced, freshness, gaps. Use when asked how the playbook/plugin/workflow system is doing or whether it's worth it; also good monthly.
---

# Pulse — is the system earning its keep here?

Announce on its own line: `📘 agent-playbook:pulse — measuring what the system has captured in this repo`

Read-only. Gather with ls/grep, then report.

## 1. Gather

- **Gotchas**: entries per file in `docs/gotchas/` (entries start with `>`), date of newest entry.
- **Decisions**: count + newest date — from `docs/decisions/` or the repo's own convention (e.g., numbered decisions in a master doc; detect via CLAUDE.md).
- **Research/plan artifacts**: counts in `docs/research/` and `docs/plans/` (exclude TEMPLATE), dates; in plans, fraction of phases that carry a **Verify** line.
- **CLAUDE.md**: line count vs the 60-line budget.
- **Recency**: newest artifact date overall — is the system alive or was it set up and abandoned?

## 2. Report

A short table (metric | value | read), then a plain-English verdict. Reads:

- **Gotchas growing in weeks 1–4, then slowing** = healthy (early capture, then fewer repeat mistakes). Zero gotchas after weeks of active work = `/learn` isn't firing or standards are too strict — flag it.
- **Decisions fresh** = choices are surviving into future sessions. None logged in a month of active work = decisions are evaporating in chat.
- **Plans with Verify lines on every phase** = the done-means-proven loop is real. Phases without them = flag.
- **CLAUDE.md flat or shrinking** while gotchas/rules grow = right shape. Growing = the always-loaded file is absorbing what belongs elsewhere.
- **Stale everything** (no artifacts in 30+ days of commits) = the system is installed but not used — say so bluntly.

## 3. The metric only a human knows

End by asking: *"Have you corrected the agent for the same thing twice recently?"* Falling correction rate is the real success metric; artifact counts are proxies for it. If the answer is yes, the miss belongs in gotchas right now — offer to log it.
