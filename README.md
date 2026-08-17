# Agent Playbook

A living playbook for working with coding agents (Claude Code first; tool-agnostic where possible). Built from published practice at Anthropic, Cognition, HumanLayer, and the engineers running the most agent-heavy workflows in the industry — see [PHILOSOPHY.md](PHILOSOPHY.md) for the principles and sources, updated as new research lands.

Two parts:

- **[playbook/](playbook/)** — the guides your team reads once: context files, logging knowledge, the core workflow, verification, token optimization, rollout, client work.
- **[kit/](kit/)** — the project-state files your team copies into a repo **once** (they're meant to diverge): CLAUDE.md template, docs scaffolding, verify-app, settings.

There is a third directory, **[plugins/](plugins/)**, but it is **deprecated** — see below.

This repo runs its own system — see [docs/decisions/](docs/decisions/) for our decision log and [CLAUDE.md](CLAUDE.md) for how agents work here.

## Setup: getting the workflows

**Nothing to install.** Copy `kit/` into your repo (next section) and you're done — the workflow lives in `CLAUDE.md` and the `docs/` scaffolding, which every agent reads on its own.

The instructions tell the agent to research before implementing, write the plan down, record gotchas after a real failure, and log decisions as ADRs. No slash commands, no marketplace, no per-environment install — so it works identically in the terminal, in a cloud session, and for a teammate who just cloned the repo.

**Deprecated: the plugin.** `plugins/` used to serve these workflows as a Claude Code plugin (`/learn`, `/log-decision`, `/research`, `/plan`, code-simplifier), pinned by adopters in `settings.json`. It is no longer the recommended path and the kit no longer installs it. It is kept published so existing installs don't break; expect no further work on it.

Why it was dropped: the machinery added an install surface, a per-environment failure mode, and a central dependency, in exchange for automating steps a competent agent will do when simply told to. The instructions were doing the work.

## Adopt in a repo in ~10 minutes

1. Copy the contents of `kit/` into your repo root (`.claude/`, `docs/`, `CLAUDE.md.template`).
2. Fill in `CLAUDE.md.template` (project description, exact commands, stack, boundaries) and rename it `CLAUDE.md`. Keep it ≤ 60 lines.
3. Symlink it for other tools: `ln -s CLAUDE.md AGENTS.md`.
4. In `.claude/settings.json`, adjust the allowlist to your build/test/lint commands.
5. Fill in `.claude/agents/verify-app.md` with how to actually run and check your app.
6. Commit all of it. It's team config — review changes like code.

Adopt once per repo. The copies are expected to drift — that is the design, not neglect. Improvements here do not flow back into repos that already adopted; re-copy a file deliberately if you want a change.

Then run the loop that makes it compound:

- Agent makes a mistake → add a `docs/gotchas/` entry before ending the session.
- Team makes a call worth remembering → append an ADR in `docs/decisions/`.
- Starting non-trivial work → research the area and write the plan down before implementing.

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
| [09 — Context management](playbook/09-context-management.md) | Compaction with intent, handoff notes, subagents, and a status line that watches for you |

**Seeing it work.** There is no badge to watch for — look at the artifacts. A repo where this is working accumulates dated entries in `docs/gotchas/`, ADRs in `docs/decisions/`, and research/plan docs that later sessions actually cite. If those stay empty, the workflow isn't running, whatever the transcript says.
