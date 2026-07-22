---
name: research
description: Research the codebase and write a compact artifact to docs/research/. Use PROACTIVELY before implementing any change that touches multiple files or an unfamiliar area — do not start coding a non-trivial task without a research artifact. First phase of research → plan → implement.
---

# Research: $ARGUMENTS

Produce `docs/research/YYYY-MM-DD-<topic>.md` following `docs/research/TEMPLATE.md`.

1. Restate the question/task in one sentence; confirm with the user if ambiguous.
2. **Use subagents for the noisy exploration** (searching, reading many files) so raw file contents stay out of this context. Ask them for summaries: relevant files + why, how the flow works, existing patterns to follow.
3. Check `docs/decisions/` for prior decisions touching this area, and `docs/gotchas/` for relevant domain files.
4. Write the artifact:
   - Summary answer up top — a reader should be able to stop there
   - Relevant files, one line each on why they matter
   - How it works (prose, reference paths, don't paste code)
   - Constraints & prior decisions (link ADRs)
   - Open questions for a human
5. Keep it to roughly one page. It replaces thousands of lines of raw file reads for whoever (or whatever session) comes next — completeness of *understanding*, not of *content*.

Do not propose solutions or write a plan. That's `/plan`'s job, ideally in a fresh session.
