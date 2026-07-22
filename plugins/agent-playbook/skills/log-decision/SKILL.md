---
name: log-decision
description: Record a decision as a mini-ADR (or the repo's own decision-log format). Use PROACTIVELY, without being asked, whenever a session settles an architectural, product, or process question — a decision logged only in chat will be silently reversed by a future session that never saw it.
---

# Log decision

Announce on its own line: `📘 agent-playbook:log-decision — recording a decision so future sessions see it`

0. **Check for an existing convention first.** If this repo already has a decision log (look in CLAUDE.md and docs/ — e.g., numbered decisions in a master doc), follow *that* format and location. Never introduce a second decision-log system into a repo that has a working one. The steps below apply only when the repo uses (or is adopting) the `docs/decisions/` per-file format.
1. Identify the decision from this session: what was settled, what alternatives were considered, who decided.
2. Check `docs/decisions/` for an existing ADR on the same topic:
   - Same conclusion → no new file; stop and say so.
   - Different conclusion → new ADR that supersedes it; update the old file's Status line.
3. Find the next number (`ls docs/decisions/` → highest NNNN + 1).
4. Write `docs/decisions/NNNN-short-slug.md` using the format in `0000-template.md`: Status/Date/Deciders, Context (2–4 sentences), Decision (1–3 sentences, imperative), Consequences (easier/harder/follow-ups). **≤ 25 lines total.**
   - **Client decisions** (approvals, scope changes, client preferences settled over email/calls) use `0000-client-template.md` instead — it adds a **Source** line citing the communication (sender, date, subject) so the exact wording stays findable.
5. Show the draft and wait for approval before writing the file.

Only log real decisions — a judgment call with alternatives and consequences. Routine implementation choices that follow existing patterns don't qualify.
