# Plan: payroll CSV export (SAMPLE — fictional but realistic)

- **Date:** 2026-07-22
- **Research:** [sample-research.md](sample-research.md)
- **Goal:** Payroll page has a "download CSV" button whose output always matches the signed report.

## Out of scope

- Excel/XLSX format; scheduled/emailed exports (would violate pull-only); any change to `build_report()` logic.

## Phase 1 — Backend endpoint

- Steps: add `GET /payroll/report.csv` in `payroll_routes.py`, calling `build_report()` and serializing rows (same columns as PDF table); filename `payroll_<start>_to_<end>.csv`.
- Files: `platform/backend/app/routes/payroll_routes.py`
- **Verify:** `cd platform/backend && .venv/bin/python -m evals.test_timesheet_formats` passes; `curl -s localhost:8000/payroll/report.csv?period=demo | head -3` shows header + rows matching the PDF for demo v0.1 data.

## Phase 2 — Frontend button

- Steps: copy the PDF download button pattern in `Payroll.tsx`; lowercase label ("download csv"), same confirmation-free pull-only behavior.
- Files: `platform/frontend/src/pages/Payroll.tsx`
- **Verify:** `npm run build` green; button downloads a file whose totals match the on-screen table for demo data.

## Phase 3 — Agreement test

- Steps: add an offline eval case asserting CSV totals == report totals for a fixture period (guards the reuse-build_report constraint permanently).
- Files: `evals/` (beside `test_timesheet_formats`)
- **Verify:** new case fails if CSV route re-queries raw tables (test by temporarily breaking it), passes on the real implementation.

## Final verification

Run verify-app: both eval gates, frontend build, then restage demo v0.1 → download CSV → totals match the signed report preview for the same period.
