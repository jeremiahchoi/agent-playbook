# 0001 — Markdown for knowledge, tracker for work state

- **Status:** accepted
- **Date:** 2026-07-21
- **Deciders:** jj

## Context

Round-1 research suggested logging everything (decisions, lessons, research, plans, session logs, bugs) as markdown. Round-2 research surfaced the markdown-rot failure mode (Steve Yegge/Beads): agents tracking status in prose produce hundreds of stale plan files, while top teams keep work state in structured trackers.

## Decision

The playbook prescribes markdown only for knowledge that compounds: decisions, gotchas, research and plan artifacts. Bugs and task status go to the team's issue tracker; history lives in git; session logs are dropped from the core kit.

## Consequences

- Fewer files to maintain; the ones that exist stay trusted.
- Teams doing long-horizon agent work may want Beads or similar — noted on the PHILOSOPHY.md watchlist.
- Plans/research are dated snapshots and allowed to go stale by design.
