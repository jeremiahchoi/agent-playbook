# 0005 — Usefulness is measured by scanning artifacts, not telemetry

- **Status:** accepted
- **Date:** 2026-07-22
- **Deciders:** jj

## Context

jj wants an indicator of how useful the plugin is. Options: build usage telemetry (invocation counts, some log pipeline) or measure from what the system leaves behind in each repo.

## Decision

Ship a `/pulse` skill that scans the repo's own artifacts — gotcha entries and dates, decisions logged, plans with verification lines, CLAUDE.md budget — and reports a scorecard with interpretation. No telemetry infrastructure.

## Consequences

- Zero infra, works offline, per-repo, and the metrics are the ones chapter 06 already defines (correction rate proxies).
- Can't measure cross-repo or team-aggregate usage; if that's ever needed, telemetry becomes a real decision to revisit.
- The honest limitation is stated in the skill: artifact counts are proxies; falling correction rate is the real metric, and only a human knows it.
