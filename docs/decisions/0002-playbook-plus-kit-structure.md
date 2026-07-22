# 0002 — Structure the repo as playbook + copy-in kit, anchored by PHILOSOPHY.md

- **Status:** accepted
- **Date:** 2026-07-21
- **Deciders:** jj

## Context

This repo must both teach the workflow and make adoption near-instant for teams. Research showed adoption lives or dies on a copy-paste path, and that recommendations drift unless anchored to sources that can be re-reviewed as the field moves.

## Decision

Split the repo into `playbook/` (guides humans read once) and `kit/` (files copied verbatim into target repos). `PHILOSOPHY.md` holds principles + a dated source library and is the source of truth: research updates land there first, then propagate to chapters and kit.

## Consequences

- Kit files must stay copy-paste ready (ALL_CAPS placeholders only).
- Every recommendation is auditable against a source; stale advice is discoverable by re-checking dated sources.
- This repo dogfoods its own system (this decision log, the kit's skills symlinked in).
