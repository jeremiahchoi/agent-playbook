# 0003 — Distribute workflow machinery as a plugin, copy only project state

- **Status:** accepted
- **Date:** 2026-07-21
- **Deciders:** jj

## Context

The original kit copied skills and agents into every adopting repo, so improvements to the playbook wouldn't propagate — every repo would drift. jj's requirement: update agent-playbook once, all workflows update everywhere.

## Decision

Split by whether content should diverge. Workflow machinery (/learn, /log-decision, /research, /plan, code-simplifier) lives in `plugins/agent-playbook/`, served from this repo via `.claude-plugin/marketplace.json`; adopting repos pin it with `extraKnownMarketplaces` + `enabledPlugins` in settings.json, so it auto-installs on workspace trust and updates centrally (commit-SHA versioning while under active development). Project state (CLAUDE.md, docs/ scaffolding, verify-app, permissions) stays a one-time copy from `kit/`.

## Consequences

- One push to this repo updates skills for every adopter; no re-copying.
- Plugins can't ship CLAUDE.md/standing instructions, so the template remains a manual copy — acceptable since it's meant to diverge.
- When teams want stability over freshness, add an explicit `version` to marketplace.json and bump deliberately.
