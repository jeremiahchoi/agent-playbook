---
name: research
description: Research a task or question about the codebase and write a compact research artifact to docs/research/. First phase of research → plan → implement; use before planning any non-trivial change.
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
