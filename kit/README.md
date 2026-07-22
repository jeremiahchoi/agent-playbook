# Kit — copy these files into your repo

Everything here goes to your repo root, **once**. These are the project-state files that are *supposed* to diverge per repo. The workflow machinery (`/learn`, `/log-decision`, `/research`, `/plan`, code-simplifier) is NOT copied — it arrives automatically via the agent-playbook plugin, pinned in `settings.json` below, and updates centrally when the playbook repo updates.

Placeholders are ALL_CAPS — search for them after copying.

| File | What it is | What to do |
|---|---|---|
| `CLAUDE.md.template` | Always-loaded agent instructions | Fill in, rename to `CLAUDE.md`, keep ≤ 60 lines, then `ln -s CLAUDE.md AGENTS.md` |
| `docs/decisions/` | Decision log (mini-ADRs) | Keep the templates; agents propose entries via `/log-decision`. Client decisions use `0000-client-template.md` (adds a Source line) |
| `docs/gotchas/` | Append-only lessons, one file per domain | Agents propose entries via `/learn` |
| `docs/research/`, `docs/plans/` | Dated artifacts from `/research` and `/plan` | Keep the templates |
| `.claude/agents/verify-app.md` | Your project's verification gate | Fill in with your real run/check commands — this one is per-project by design |
| `.claude/settings.json` | Plugin auto-install + starter permission allowlist | Keep the `extraKnownMarketplaces`/`enabledPlugins` keys as-is; replace the `npm` commands with your build/test/lint commands |

When a teammate clones the repo and trusts the workspace, the plugin marketplace registers and the skills enable automatically — no install commands.

Commit all of it — it's team config; review changes like code.
