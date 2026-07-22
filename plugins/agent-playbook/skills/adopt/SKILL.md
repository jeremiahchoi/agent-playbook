---
name: adopt
description: Retrofit the current repo to the agent-playbook system — plugin settings, verify-app, docs scaffolding, lean CLAUDE.md — while deferring to the repo's existing conventions. Use when asked to adopt, retrofit, or set up agent-playbook (or "the workflow system") in a repo.
---

# Adopt agent-playbook in this repo

Additive only — never delete or rewrite working content. Learned from real retrofits: **defer to existing conventions; never introduce a second system beside a working one.**

## 1. Recon (read, don't write)

- Existing `CLAUDE.md`/`AGENTS.md`, `.claude/` contents, and any docs conventions: a decision log (e.g., numbered decisions in a master doc), lessons/gotchas files, plan/research dirs. Whatever exists and is *actually used* wins; empty placeholder files get converted to pointers at the live location, not deleted.
- Detect stack and exact commands (package.json / pyproject / Makefile): build, test (single-test form), lint, typecheck, run.
- Git state: repo? teammates/PR conventions? If shared, do all work on a branch.

## 2. Propose before writing

Show a keep / trim / add summary and wait for approval. Include which conventions you're preserving.

## 3. Create

- **`.claude/settings.json`** — merge into existing if present:
  ```json
  {
    "extraKnownMarketplaces": {
      "agent-playbook": { "source": { "source": "github", "repo": "jeremiahchoi/agent-playbook" }, "autoUpdate": true }
    },
    "enabledPlugins": { "agent-playbook@agent-playbook": true },
    "permissions": {
      "allow": ["Bash(git status)", "Bash(git diff:*)", "Bash(git log:*)", "Bash(git add:*)"],
      "deny": ["Read(**/.env)", "Read(**/.env.*)"]
    }
  }
  ```
  Add detected build/test/lint commands to `allow`. Ask whether to deny `Bash(git push:*)` (conservative team default) or leave pushes prompt-gated.
- **`.claude/agents/verify-app.md`** — the project's verification gate: frontmatter (name, description "Use PROACTIVELY before declaring any non-trivial change done", tools: Bash, Read, Grep, Glob), then numbered steps with the repo's *real* commands: static checks, tests, then actually running/exercising the app. If you can't detect how to exercise the app end-to-end, ask the user — this file is the whole point.
- **Docs scaffolding** — `docs/gotchas/README.md` (append-only, 1–3 line dated entries, must trace to real failures, one file per domain — **start empty, never backfill**); `docs/research/TEMPLATE.md` and `docs/plans/TEMPLATE.md` (copy from `~/.claude/plugins/marketplaces/agent-playbook/kit/docs/` if present, else fetch from the public repo, else write from the playbook's format: research = summary/files/flow/constraints/open questions; plan = goal/out-of-scope/phases each with a Verify line/final verification). `docs/decisions/` with the ADR template **only if** the repo has no existing decision log.
- **`CLAUDE.md`** — if missing, generate from the codebase and keep ≤ 60 lines (description, stack+versions, exact commands, always/ask/never boundaries). If present and over budget, propose trims (don't cut unilaterally). Either way, append a short "Agent workflows" section: research→plan before non-trivial work; check gotchas before working in an area; run verify-app before claiming done; learn/log-decision at wrap-up, following this repo's decision-log convention.
- **`AGENTS.md`** — symlink to CLAUDE.md if absent.
- **`.gitignore`** — add `.claude/settings.local.json`, `CLAUDE.local.md`.

## 4. Finish

Commit on a branch with a summary of what was preserved vs added; suggest a PR for shared repos. Tell the user: teammates now get the skills by clone + workspace trust, nothing to install. Offer (don't do unprompted): backfill 3–5 foundational ADRs from git history if the repo had no decision log.
