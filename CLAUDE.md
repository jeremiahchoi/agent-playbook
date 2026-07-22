# Agent Playbook repo

Docs-only repo: `playbook/` (guides for humans) + `kit/` (files teams copy into their repos) + `PHILOSOPHY.md` (principles & sources). No build, no tests.

## Rules

- PHILOSOPHY.md is the source of truth. Playbook chapters and kit files must not contradict it. When new research changes a principle: update PHILOSOPHY.md first (source + date in the library table), then the affected chapters, then the kit.
- Every recommendation must trace to a source in PHILOSOPHY.md or a real observed failure. No aspirational advice.
- Kit files must be copy-paste ready. Placeholders are ALL_CAPS and explained in kit/README.md.
- Keep it lean: `kit/CLAUDE.md.template` ≤ 60 lines; playbook chapters ≤ ~150 lines. This playbook follows its own advice.
- Record structural decisions in docs/decisions/ (use /log-decision). Check existing decisions before restructuring.
- Capture lessons about maintaining this repo with /learn into docs/gotchas/.
