# 0004 — Retrofitting is a plugin skill, not a manual kit copy

- **Status:** accepted
- **Date:** 2026-07-22
- **Deciders:** jj

## Context

Adoption previously required manually copying `kit/` and applying judgment (defer to conventions, don't backfill gotchas, placeholders → pointers) that lived only in the bee retrofit session. Ad-hoc "retrofit this repo" prompts would reproduce that judgment inconsistently across teammates.

## Decision

Ship an `/adopt` skill in the plugin that encodes the retrofit procedure and its learned rules. Anyone with a user-scope install can turn any repo into an adopted repo by running it; the kit remains as reference material and template source.

## Consequences

- Adoption drops to one command; retrofit lessons compound in the skill instead of in chat history.
- The skill must stay in sync with kit templates (it copies from the marketplace clone or the public repo).
- Retrofit judgment improvements now propagate via plugin updates like everything else.
