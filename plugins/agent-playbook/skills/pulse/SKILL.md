---
name: pulse
description: Scorecard of whether the agent-playbook system is actually helping in this repo — knowledge captured, artifacts produced, verification coverage, freshness, and the repeat-correction check. Use when asked how the playbook/plugin/workflow system is doing or whether it's worth it; good monthly.
---

# Pulse — is the system earning its keep here?

Announce on its own line: `📘 agent-playbook:pulse — measuring what the system has produced in this repo`

Read-only. Gather, then report. **Never guess numbers — if something can't be measured, say "not measured" rather than estimating.**

## 1. Gather

Adoption:
- Is this repo adopted? (`.claude/settings.json` with the plugin keys, `.claude/agents/verify-app.md`, `docs/gotchas/`)
- `CLAUDE.md` line count vs the 60-line budget.

Output (counts + newest date for each):
- **Gotchas**: entries across `docs/gotchas/*.md` (lines starting with `>`).
- **Decisions**: `docs/decisions/` files, or the repo's own convention (detect via CLAUDE.md — e.g. numbered decisions in a master doc).
- **Research / plans**: files in `docs/research/`, `docs/plans/` (exclude TEMPLATE). In plans, the fraction of phases carrying a **Verify** line.

Context layer:
- Status line wired? (`.claude/statusline.sh` exists AND `statusLine` key in `.claude/settings.json`)
- `.claude/HANDOFF.md` in `.gitignore`? Does a handoff note exist, and how fresh is it vs the newest commit?

Kit drift (answers "do I need to re-adopt?"):
- Compare the repo's kit-side files against the current kit (marketplace clone at `~/.claude/plugins/marketplaces/agent-playbook/kit/`, else the public repo): anything the kit now ships that this repo lacks (e.g., a repo adopted before the status line existed)? List each missing piece by name. Customized files (verify-app, settings allowlist) are *supposed* to differ — only flag absent pieces, never content differences.

Activity baseline (so output is judged against real work, not calendar time):
- `git log --oneline --since="30 days ago" | wc -l` — commits in the last 30 days.
- Newest artifact date overall vs newest commit date.

## 2. Report

A compact table (metric | value | read), then a two-line verdict in plain English. How to read it:

- **Artifacts per unit of work** is the real signal. 40 commits and zero gotchas in 30 days = the capture loop isn't firing. 3 commits and zero gotchas = fine, nothing happened yet.
- **Gotchas growing early then slowing** = healthy: capture up front, then fewer repeat mistakes. Growing forever = the same class of mistake may be recurring; check whether entries are enforceable (convert to hooks/lint).
- **Decisions fresh** = choices are surviving into future sessions. None in a month of active work = decisions are evaporating in chat.
- **Plans with Verify on every phase** = done-means-proven is real. Phases without = flag them by name.
- **CLAUDE.md flat/shrinking while gotchas grow** = right shape. Growing = the always-loaded file is absorbing what belongs in gotchas, rules, or skills.
- **Stale everything** (no artifacts while commits continue) = installed but unused. Say so bluntly; don't soften it.
- **Kit drift** = list missing pieces and close with: *"re-run /adopt to pick these up — it proposes only the delta."* No drift = say adoption is current, no re-adopt needed.
- **Context layer absent** in an active repo = sessions are relying on auto-compact at ~83%, i.e., quality is degrading before anyone notices. Recommend wiring the status line first — it's the piece that makes the other problems visible.

## 3. The metric only a human has

Close by asking directly: **"Have you corrected the agent for the same thing twice in the last couple weeks?"**

Falling repeat-correction rate is the actual success measure — artifact counts are proxies for it. If the answer is yes, that miss is a real observed failure: offer to run `learn` on it right now, and note which rung of the [automation ladder](playbook/08-automation.md) would have caught it (description → bootstrap → Stop hook).

Then give a one-line recommendation: keep going as-is, or the single highest-value fix.
