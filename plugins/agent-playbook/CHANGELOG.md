# Changelog

## 0.4.1 — 2026-07-24
PreCompact hook: every compaction (auto or manual) now receives handoff-shaped preserve/drop instructions, so session state survives mechanically even when nobody noticed the window filling. Gotcha: desktop app doesn't render status lines — CLI-only.

## 0.4.0 — 2026-07-24
Context management layer: `handoff` skill, context clauses + version announcement in the bootstrap, kit status line (context meter, python3-only), `/pulse` gains context-layer, kit-drift, and version-freshness checks. VERSION/CHANGELOG introduced.

## 0.3.0 — 2026-07-24
Visible 📘 indicators on every skill/agent, `/adopt` doc consolidation (standardize by rename), `/pulse` scorecard, activity-baseline metrics.

## 0.2.0 — 2026-07-22
`/adopt` one-command retrofit, proactive (auto-firing) skill descriptions, SessionStart bootstrap hook, adopted-vs-not verify guidance (Ray's fix, PR #1).

## 0.1.0 — 2026-07-21
Initial skills: research, plan, learn, log-decision; code-simplifier agent.
