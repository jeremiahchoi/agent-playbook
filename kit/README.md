# Kit — copy these files into your repo

Everything here goes to your repo root. Placeholders are ALL_CAPS — search for them after copying.

| File | What it is | What to do |
|---|---|---|
| `CLAUDE.md.template` | Always-loaded agent instructions | Fill in, rename to `CLAUDE.md`, keep ≤ 60 lines, then `ln -s CLAUDE.md AGENTS.md` |
| `docs/decisions/` | Decision log (mini-ADRs) | Keep the templates; agents propose entries via `/log-decision`. Client decisions use `0000-client-template.md` (adds a Source line) |
| `docs/gotchas/` | Append-only lessons, one file per domain | Agents propose entries via `/learn` |
| `docs/research/`, `docs/plans/` | Dated artifacts from `/research` and `/plan` | Keep the templates |
| `.claude/skills/` | `/learn`, `/log-decision`, `/research`, `/plan` | Works as-is |
| `.claude/agents/` | `verify-app`, `code-simplifier` subagents | Fill in `verify-app.md` with your real run/check commands |
| `.claude/settings.json` | Starter permission allowlist | Replace the `npm` commands with your build/test/lint commands |

Commit all of it — it's team config; review changes like code.
