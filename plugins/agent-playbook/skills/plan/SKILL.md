---
name: plan
description: Turn a research artifact into a phased implementation plan in docs/plans/, with verification per phase. Use PROACTIVELY after research and before writing any implementation code for non-trivial work. Second phase of research → plan → implement.
---

# Plan: $ARGUMENTS

Produce `docs/plans/YYYY-MM-DD-<feature>.md` following `docs/plans/TEMPLATE.md`.

0. Announce on its own line: `📘 agent-playbook:plan — turning research into a phased, verifiable plan`
1. Read the relevant `docs/research/` artifact (ask which one if unclear; if none exists, suggest running `/research` first).
2. Draft the plan:
   - Goal in one sentence; link the research doc
   - **Out of scope** — explicit, before the phases
   - Phases, each with: concrete steps, files to change, and a **Verify** line with the exact command or check proving the phase works. No phase without verification.
   - Final end-to-end verification that proves the feature works, not just that tests pass
3. Review your own draft as a skeptical staff engineer: does any phase depend on an unverified assumption? Is any phase too big to verify in one shot? Split it.
4. Show the plan for human review before saving. The plan review is the team's highest-leverage moment — make the plan precise enough that a fresh session could execute it without this conversation.

Do not start implementing. Implementation happens in a fresh session: "implement docs/plans/<file>, phase by phase, running each phase's verification before moving on."
