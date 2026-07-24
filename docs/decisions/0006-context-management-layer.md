# 0006 — Context management is a first-class layer, separate from token optimization

- **Status:** accepted
- **Date:** 2026-07-24
- **Deciders:** jj

## Context

The playbook covered what gets *loaded* (chapter 05) but nothing about what happens to a session as it *runs*. Anthropic's context-engineering guidance names three long-horizon techniques (compaction, structured note-taking, sub-agent architectures); we practiced only the third, and the degradation curve (quality drops well before the ~83% auto-compact fires) was unaddressed.

## Decision

Add chapter 09 plus machinery: a `handoff` skill (structured note-taking to `.claude/HANDOFF.md`), context clauses in the SessionStart policy, and a status line shipped in the kit showing live context usage with 50%/70% thresholds. Compaction guidance is explicit-instruction-based and breakpoint-driven, not auto-fire-driven.

## Consequences

- The status line requires only python3 (jq dependency removed same week — no manual installs allowed in the adoption path) and is opt-out during `/adopt`.
- Handoff notes are gitignored session state; durable knowledge still goes to gotchas/decisions/plans.
- Adds a fourth thing users can see the plugin doing, which also serves the visibility goal.
