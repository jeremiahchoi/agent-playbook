# Kit — copy these files into your repo

Everything here goes to your repo root, **once**. These are the project-state files that are *supposed* to diverge per repo.

There is no plugin and nothing to install — the workflow is instructions, not machinery. `CLAUDE.md` tells the agent to research before implementing, log decisions, and record gotchas; the agent does those steps directly. Copies never auto-update, which is the point: each repo's copy drifts to fit that repo.

Placeholders are ALL_CAPS — search for them after copying. `bin/adopt.sh` (repo root) does the copy for you: no-overwrite, `--dry-run`, and it prints the placeholders left to fill.

| File | What it is | What to do |
|---|---|---|
| `CLAUDE.md.template` | Always-loaded agent instructions | Fill in, rename to `CLAUDE.md`, keep ≤ 60 lines, then `ln -s CLAUDE.md AGENTS.md` |
| `docs/decisions/` | Decision log (mini-ADRs) | Keep the templates; agents append an ADR when a session settles something. Client decisions use `0000-client-template.md` (adds a Source line) |
| `docs/gotchas/` | Append-only lessons, one file per domain | Agents append an entry at wrap-up after a real failure |
| `docs/research/`, `docs/plans/` | Dated research and plan artifacts | Keep the templates |
| `.claude/agents/verify-app.md` | Your project's verification gate | Fill in with your real run/check commands — this one is per-project by design |
| `.claude/settings.json` | Starter permission allowlist | Replace the `npm` commands with your build/test/lint commands |

A teammate who clones the repo gets all of this from the files themselves — no install step, no marketplace, no trust prompt beyond the usual one.

Commit all of it — it's team config; review changes like code.
