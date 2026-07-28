# Changelog

## 0.4.2 — 2026-07-24
**Context alerts that actually fire.** New UserPromptSubmit hook injects a warning into the conversation at 70%/85% (or 400k/700k absolute) — works in the desktop app, where status lines don't render and a session cannot otherwise perceive its own usage. Shared `context-check.py` fixes 1M-window math (was reporting 456% on a 912k session), clamps to 0–100, and infers window size; status line reuses it with an inline fallback.

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
