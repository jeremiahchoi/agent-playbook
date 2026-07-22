# Agent Playbook

A living playbook for working with coding agents (Claude Code first; tool-agnostic where possible). Built from published practice at Anthropic, Cognition, HumanLayer, and the engineers running the most agent-heavy workflows in the industry — see [PHILOSOPHY.md](PHILOSOPHY.md) for the principles and sources, updated as new research lands.

Three parts:

- **[playbook/](playbook/)** — the guides your team reads once: context files, logging knowledge, the core workflow, verification, token optimization, rollout, client work.
- **[kit/](kit/)** — the project-state files your team copies into a repo **once** (they're meant to diverge): CLAUDE.md template, docs scaffolding, verify-app, settings.
- **[plugins/](plugins/)** — the workflow machinery (`/learn`, `/log-decision`, `/research`, `/plan`, code-simplifier), served from this repo as a Claude Code plugin. Adopting repos pin it in settings.json, so **updating this repo updates every adopter** — no re-copying.

This repo runs its own system — see [docs/decisions/](docs/decisions/) for our decision log and [CLAUDE.md](CLAUDE.md) for how agents work here.

## Setup: getting the workflows

**For a team repo — zero commands.** Adopt the kit (next section). After that, anyone who clones the repo, opens it in Claude Code, and accepts the one-time "trust this workspace" prompt gets the skills automatically — `.claude/settings.json` registers this repo's plugin marketplace and enables the plugin. Nothing to install beyond Claude Code itself.

**For yourself, in every project — one-time install.** In the Claude Code terminal CLI (any directory), run:

```
/plugin marketplace add jeremiahchoi/agent-playbook
/plugin install agent-playbook@agent-playbook
```

Choose **user** scope when prompted. The skills (`/learn`, `/log-decision`, `/research`, `/plan`) then follow you into every project on your machine, including ones that never adopted the kit. Repo scope and user scope stack fine.

**Updates.** The kit's settings set `"autoUpdate": true` on the marketplace entry; if your Claude Code version honors it at project scope, updates are fully automatic (new commits here = new plugin versions, applied on next session launch). Belt-and-suspenders for teammates: enable auto-update once in `/plugin` → Marketplaces → agent-playbook. Manual fallback any time: `/plugin update agent-playbook@agent-playbook` (also works non-interactively as `claude plugin update ...` for cron/CI).

## Adopt in a repo in ~10 minutes

1. Copy the contents of `kit/` into your repo root (`.claude/`, `docs/`, `CLAUDE.md.template`).
2. Fill in `CLAUDE.md.template` (project description, exact commands, stack, boundaries) and rename it `CLAUDE.md`. Keep it ≤ 60 lines.
3. Symlink it for other tools: `ln -s CLAUDE.md AGENTS.md`.
4. In `.claude/settings.json`: keep the plugin keys as-is, adjust the allowlist to your build/test/lint commands.
5. Fill in `.claude/agents/verify-app.md` with how to actually run and check your app.
6. Commit all of it. It's team config — review changes like code.

The skills themselves aren't copied: when anyone clones the repo and trusts the workspace, the settings' `extraKnownMarketplaces`/`enabledPlugins` keys register this repo's plugin marketplace and enable the skills automatically. They update centrally when this repo updates.

Then run the loop that makes it compound:

- Agent makes a mistake → run `/learn` before ending the session.
- Team makes a call worth remembering → run `/log-decision`.
- Starting non-trivial work → `/research` then `/plan` before implementing.

## The one rule

**No correction happens only in chat.** Every mistake ends as a CLAUDE.md line, a gotcha entry, a hook, or a test. That's what makes week 10 faster than week 1.

## Playbook chapters

| Chapter | What it covers |
|---|---|
| [01 — Context files](playbook/01-context-files.md) | CLAUDE.md, rules, skills, hooks, subagents — what goes where and what each costs |
| [02 — Logging knowledge](playbook/02-logging.md) | Decisions, gotchas, research, plans — and what *not* to log in markdown |
| [03 — Core workflow](playbook/03-workflow.md) | Research → plan → implement, subagents, parallel sessions |
| [04 — Verification](playbook/04-verification.md) | The single biggest quality lever: checks the agent runs itself |
| [05 — Token optimization](playbook/05-token-optimization.md) | Loading-cost hierarchy, cache stability, context hygiene |
| [06 — Team adoption](playbook/06-team-adoption.md) | Rollout, ownership, review norms, anti-patterns |
| [07 — Client-facing work](playbook/07-client-work.md) | Distilling client emails/decisions without wasting tokens; per-client context |
| [08 — The automation ladder](playbook/08-automation.md) | Making the workflow fire in the background: descriptions → bootstrap → Stop hooks → meta-skills |

Want to *see* it run? [examples/demo-script.md](examples/demo-script.md) is five prompts that make the background workflow fire in an adopted repo, with pass/fail checkpoints.
