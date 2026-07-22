# 06 — Team adoption

The tooling is the easy part. Adoption lives or dies on two things: a five-minute copy-paste path, and a team norm that knowledge capture is part of finishing work.

## Rollout path

**Week 1 — one repo, the kit, one champion.**
Copy `kit/` in, fill the CLAUDE.md template (≤ 60 lines), wire `verify-app` to real commands, commit. The workflow skills arrive via the agent-playbook plugin pinned in `settings.json` — teammates get them (and future updates) automatically on workspace trust, no install step. The champion runs the compounding loop personally: every agent mistake → `/learn`; every judgment call → `/log-decision`.

**Weeks 2–3 — make capture visible.**
Demo in standup/Slack when a captured gotcha saves someone. Cognition's observation: adoption spreads when engineers *see teammates' results*, not when they're told to adopt. Start requiring plans (`docs/plans/`) for non-trivial agent work and reviewing plans instead of only PRs.

**Week 4+ — automate capture.**
Add the PR-review capture loop (tag `@.claude` → GitHub Action commits the correction to CLAUDE.md — Boris Cherny's team's ritual). Add hooks for whatever gotchas turned out to be enforceable. Expand to more repos by copying the now-tuned kit, not the pristine one.

## Ownership and review norms

- **Context files are code.** CLAUDE.md, skills, settings, hooks — changed by PR, reviewed like code. No drive-by edits that bloat the file.
- **One named owner per repo** for CLAUDE.md and gotchas (usually the champion). Everyone contributes; one person prunes.
- **Agent-written docs get human approval before merge.** ADRs and gotcha entries are proposed by the agent, approved by a human. The approval is the quality gate that keeps the files trusted.
- **Plans are the team review surface.** Ten minutes on a one-page plan beats an hour on a 2,000-line PR.

## Measure whether it's working

Run `/pulse` in the repo — it scans the artifacts (gotcha entries, decisions, plans with verification, CLAUDE.md budget) and reports a scorecard against the targets below.

- **Correction rate** — are you correcting the agent for the same thing twice? Then the first correction wasn't captured. This number should visibly fall over weeks.
- **CLAUDE.md size** — should stay flat or shrink while gotchas/rules/hooks grow. Growth in the always-loaded file is a smell.
- **Fresh-session test** — ask a new session to summarize the rules; if it misses one, the file isn't working.
- **Onboarding time** — new teammate + agent + playbook should produce a first meaningful PR in days, not weeks.

## Anti-patterns to name early

- **Markdown rot** — status/tasks tracked in prose files. Work state goes in the tracker; markdown is for knowledge only.
- **Aspirational docs** — rules that don't trace to a real failure. They dilute the rules that do.
- **The encyclopedia CLAUDE.md** — someone helpfully documents everything; the agent starts ignoring half of it. Prune ruthlessly.
- **Capture as homework** — if logging happens in a separate "documentation pass," it won't happen. It's part of ending a session.
- **Tool-enforceable prose** — style rules living as instructions instead of linters/hooks.
