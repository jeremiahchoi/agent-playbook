---
name: learn
description: Scan the current session for reusable lessons and file them into docs/gotchas/ or CLAUDE.md. Run at the end of any session where a mistake was made or something non-obvious was discovered.
---

# Learn — capture this session's lessons

1. Review this session for:
   - Mistakes I made that a written rule would have prevented
   - Non-obvious facts about this codebase discovered the hard way (APIs that don't work as expected, hidden constraints, misleading names)
   - Corrections the user gave me more than once

2. For each candidate, pick the destination:
   - **Enforceable by a tool** (lint/format/blockable) → propose a hook or lint rule instead of prose
   - **Applies to every session** → propose a one-line addition to CLAUDE.md (be reluctant — that file is expensive)
   - **Domain-specific** → append to `docs/gotchas/<domain>.md` (create the file if the domain is new). If the repo already has its own lessons convention (check CLAUDE.md and docs/), follow that instead — never introduce a second system.

3. Format gotcha entries as 1–3 lines, with date and origin:
   > Lesson stated as an instruction — with the why. (YYYY-MM, PR/context)

4. Apply the scar-tissue standard: every entry must trace to a real failure or discovery **in this session**. If I can't point to the moment it would have prevented, drop it.

5. Show the proposed entries and destinations, wait for approval, then write them. If nothing qualifies, say so — an empty result is better than a diluting entry.
