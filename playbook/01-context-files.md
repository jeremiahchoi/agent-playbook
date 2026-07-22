# 01 — Context files: what goes where

Claude Code has five mechanisms for giving an agent standing knowledge. They differ in *when they load* — and therefore what they cost every session.

| Mechanism | When it loads | Cost | Use for |
|---|---|---|---|
| `CLAUDE.md` / unscoped rules | Every session, always | Highest | Only what every session needs |
| Path-scoped rules (`.claude/rules/*.md` with `paths:` frontmatter) | When the agent touches matching files | Medium | Per-area conventions (frontend rules load only for frontend files) |
| Skills (`.claude/skills/<name>/SKILL.md`) | Name+description always; body only on invocation | Low | Procedures: deploy checklist, release flow, the logging skills |
| Hooks (`.claude/settings.json`) | Never enters context; runs deterministically | ~Zero | Anything enforceable: format-after-edit, block writes to migrations |
| Subagents (`.claude/agents/*.md`) | Isolated context; only the summary returns | ~Zero until used | Research, review, verification without polluting the main session |

## CLAUDE.md: ≤ 60 lines

The always-loaded core. For every line ask: *would removing this cause the agent to make mistakes?* If not, cut it. Include:

1. **One-paragraph project description** — what it is, for whom.
2. **Exact commands with flags** — build, test (single-test form), lint, run. Commands the agent can't guess.
3. **Stack with versions** — "React 18 + TypeScript, Vite, Tailwind," not "a React app."
4. **Boundaries, three tiers** — always do / ask first / never do. ("Never commit secrets. Never edit `vendor/`. Ask before schema changes.")
5. **Pointers, not content** — "Before architectural changes, check `docs/decisions/`. Before working in `<domain>`, read `docs/gotchas/<domain>.md`."

Exclude: anything readable from the code, standard language conventions, API docs (link them), file-by-file codebase tours, and anything a linter or hook could enforce instead.

One real code snippet showing your style beats three paragraphs describing it (GitHub's finding across 2,500+ repos).

## The scar-tissue standard

Every rule in CLAUDE.md or a gotchas file should exist because an agent once failed without it (Mitchell Hashimoto's practice in Ghostty). That's also the pruning rule: if you can't remember the failure a line prevents, delete the line and see if anything regresses.

## Cross-tool compatibility

`ln -s CLAUDE.md AGENTS.md` — one source of truth that also works for Cursor, Copilot, Codex, and anything else following the AGENTS.md standard.

## Locations

- `./CLAUDE.md` — project, checked in, shared.
- `./CLAUDE.local.md` — personal, gitignored.
- `~/.claude/CLAUDE.md` — personal, all projects.
- Subdirectory `CLAUDE.md` files — pulled in on demand in monorepos; keep team-specific rules there so other teams don't pay for them.

## Maintenance

Treat these files like code: review changes in PRs, prune when the agent misbehaves despite a rule (the file is probably too long and the rule is drowning), and test changes by asking a fresh session to "summarize the rules in CLAUDE.md" — if the summary misses something, the file isn't doing its job.
