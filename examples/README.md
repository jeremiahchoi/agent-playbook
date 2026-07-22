# Examples

Two things here:

- **[demo-script.md](demo-script.md)** — five copy-paste prompts to run in a real adopted repo (written for bee) that make the background workflow fire while you watch. Each prompt says what you should see; a miss tells you which rung of the [automation ladder](../playbook/08-automation.md) to climb.
- **[sample-research.md](sample-research.md)** / **[sample-plan.md](sample-plan.md)** — what good artifacts look like (fictional bee task, marked SAMPLE). Compare your first real `/research` and `/plan` outputs against these: one page, summary up top, every plan phase carries a Verify line.

What good *log entries* look like:

**A gotcha** (`docs/gotchas/pipeline.md`):
> Pipeline eval cases assert on match *reason* strings, not just outcomes — changing a reason message breaks 3 cases even when matching is correct. Update `evals/pipeline_cases.py` expectations in the same PR. (2026-07, PR #12)

**A decision** (bee's D-number style, in `docs/research-and-planning.md`):
> **D46 — Timesheet rounding is per-entry, not per-day.** Per-day rounding can silently shave minutes across many short entries; workers'-comp reports must reconcile to raw entries. Rounding happens at display/report time only; raw minutes stored. (2026-07-22, jj)
