# Research: payroll CSV export (SAMPLE — fictional but realistic)

- **Date:** 2026-07-22
- **Question/task:** Add a CSV export of approved timesheets to the payroll page, matching the signed workers'-comp report.

## Summary

Payroll data flows from `timesheets` (raw entries) through `payroll.py::build_report()` which applies rounding and grouping before the signed PDF is generated. A CSV export should reuse `build_report()` — not re-query raw tables — or the CSV can disagree with the signed report (the exact failure the draft-first invariant exists to avoid). Frontend has an existing download pattern (PDF button on the same page) to copy. Small change: one backend endpoint, one frontend button, ~2 files plus tests.

## Relevant files

- `platform/backend/app/payroll.py` — `build_report()` is the single source of report truth; reuse it
- `platform/backend/app/routes/payroll_routes.py` — existing `/payroll/report.pdf` endpoint to mirror
- `platform/frontend/src/pages/Payroll.tsx` — PDF download button pattern to copy
- `evals/test_timesheet_formats.py` — offline gate; CSV formatting cases would live beside it

## How it works

Approved timesheets are grouped per worker per period in `build_report()`, which also applies D46 rounding (per-entry). The PDF route calls it and streams the result. A CSV route should call the same function and serialize rows, so both artifacts always agree.

## Constraints & prior decisions

- **D46**: rounding is per-entry, display-time only — CSV must not re-round
- Safety invariant: exports are pull-only (user clicks); nothing auto-sends
- Python 3.9 syntax; frontend Node 18

## Open questions

- Filename convention — include pay-period dates? (suggest `payroll_YYYY-MM-DD_to_YYYY-MM-DD.csv`)
- Should rejected/pending entries be excludable via a flag, or approved-only forever?
