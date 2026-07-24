#!/usr/bin/env bash
# PreCompact hook: fires before ANY compaction (auto at ~83% or manual /compact).
# Stdout becomes custom instructions for the compaction summarizer, so the
# summary is handoff-shaped and session state survives mechanically — even
# when nobody noticed the window filling.
echo "Compaction instructions from agent-playbook: PRESERVE IN FULL — (1) the current goal in one sentence; (2) concrete state: what is done and what is next, specific enough to resume cold; (3) every file touched, by exact path, with what changed and why; (4) every decision made this session with its reason; (5) unresolved bugs AND failed approaches already ruled out, so they are not retried; (6) the exact build/test/verify commands in use. DROP — raw tool outputs, file contents, and search results (they are re-readable from disk). After compaction: if .claude/HANDOFF.md exists, re-read it; if the work follows a doc in docs/plans/, re-read that plan and continue from its current phase."
