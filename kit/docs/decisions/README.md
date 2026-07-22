# Decision log

One file per decision, numbered sequentially (`0001-slug.md`), format in `0000-template.md`, ≤ 25 lines each.

Rules:
- Agents: check this directory before architectural changes; propose a new ADR (via `/log-decision`) whenever a session makes a decision worth remembering. A decision made only in chat will be silently reversed by a future session that never saw it.
- Humans approve before merge.
- Never edit an accepted decision's substance — supersede it with a new one and update the old file's Status line.
