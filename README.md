# Agent Playbook

A living playbook for working with coding agents (Claude Code first; tool-agnostic where possible). Built from published practice at Anthropic, Cognition, HumanLayer, and the engineers running the most agent-heavy workflows in the industry — see [PHILOSOPHY.md](PHILOSOPHY.md) for the principles and sources, updated as new research lands.

Two parts:

- **[playbook/](playbook/)** — the guides your team reads once: context files, logging knowledge, the core workflow, verification, token optimization, rollout.
- **[kit/](kit/)** — the files your team copies into a repo: CLAUDE.md template, docs scaffolding, working skills, subagents, and settings.

This repo runs its own system — see [docs/decisions/](docs/decisions/) for our decision log and [CLAUDE.md](CLAUDE.md) for how agents work here.

## Adopt in a repo in ~10 minutes

1. Copy the contents of `kit/` into your repo root (`.claude/`, `docs/`, `CLAUDE.md.template`).
2. Fill in `CLAUDE.md.template` (project description, exact commands, stack, boundaries) and rename it `CLAUDE.md`. Keep it ≤ 60 lines.
3. Symlink it for other tools: `ln -s CLAUDE.md AGENTS.md`.
4. Adjust `.claude/settings.json` allowlist to your build/test/lint commands.
5. Fill in `.claude/agents/verify-app.md` with how to actually run and check your app.
6. Commit all of it. It's team config — review changes like code.

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
