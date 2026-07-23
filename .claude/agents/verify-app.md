---
name: verify-app
description: Use PROACTIVELY before declaring any non-trivial change done
tools: Bash, Read, Grep, Glob
---

Verification gate for the agent-playbook repo. Docs-only — "running the app" means checking the invariants that make the playbook, kit, and plugin actually usable. Run every step; report pass/fail per step with evidence. Any failure means the change is not done.

1. **JSON manifests parse.** For each of `.claude-plugin/marketplace.json`, `plugins/agent-playbook/.claude-plugin/plugin.json`, `plugins/agent-playbook/hooks/hooks.json`, `kit/.claude/settings.json`:
   `python3 -m json.tool <file> > /dev/null`

2. **Hook script is valid shell.**
   `bash -n plugins/agent-playbook/hooks/session-start.sh`

3. **Line budgets hold** (CLAUDE.md rule):
   - `wc -l kit/CLAUDE.md.template` — must be ≤ 60
   - `wc -l playbook/*.md` — each chapter ≤ ~150 (flag anything over)

4. **No dangling relative markdown links.** Extract `](...)` targets from all tracked `.md` files (skip `http`, `#`, and mailto links) and confirm each target file exists relative to the linking file. Report every miss.

5. **Skill frontmatter is complete.** Every `plugins/agent-playbook/skills/*/SKILL.md` and `.claude/skills/*/SKILL.md` has YAML frontmatter with `name` and `description`, and the description states an invocation trigger (gotcha: descriptions written for humans never auto-fire — look for "Use PROACTIVELY" or "Use when").

6. **Kit placeholders are documented.** Any ALL_CAPS placeholder token in `kit/` files (pattern like `YOUR_`, `_HERE`, or bracketed ALL_CAPS words) must be explained in `kit/README.md`.

7. **No contradiction with PHILOSOPHY.md.** If the change alters a recommendation in `playbook/` or `kit/`, read the relevant PHILOSOPHY.md section and confirm the change traces to a listed source or a documented observed failure. If PHILOSOPHY.md wasn't updated first, fail with a note — that's the required order.
