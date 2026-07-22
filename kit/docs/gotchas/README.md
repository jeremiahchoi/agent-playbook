# Gotchas

Append-only lessons, one file per domain (e.g. `frontend.md`, `api.md`, `infra.md`). Maintained by `/learn`.

Entry format — 1–3 lines, dated, traceable:

> Use `stem` (file path without extension) instead of `slug` in page collection queries — `slug` doesn't exist. (2026-07, PR #142)

Rules:
- **Every entry must trace to a real observed failure or hard-won discovery.** No aspirational advice — it dilutes the entries that earned their place.
- If it needs more than 3 lines, write a doc and link it from the entry.
- If a linter or hook could enforce it, convert it and delete the entry.
- Prune on a cadence: if nobody remembers the failure behind an entry, delete it and see if anything regresses.
