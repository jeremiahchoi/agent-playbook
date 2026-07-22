# Demo script: watch the background workflow fire

Run these in a fresh Claude Code session in an adopted repo (prompts written for bee). Don't mention any skill by name — the point is watching them self-trigger. After each prompt, the ✅ line is what you should see; ❌ tells you what a miss means.

## 0. Calibration — trivial task (nothing should fire)

> fix the typo in the work-order status label: "compelte" → "complete"

✅ Just does it. No research doc, no plan.
❌ If it writes a research artifact for a typo, the skills over-trigger — tell me; we'd tighten the "non-trivial" bar in the descriptions.

## 1. Non-trivial feature — research should fire on its own

> I want a CSV export of approved timesheets on the payroll page, matching what the signed workers'-comp report shows.

✅ Before any code: announces it's researching, spawns subagents to explore, writes `docs/research/2026-MM-DD-payroll-csv-export.md`, and asks you to review the one-pager. Then (same or next turn) proposes a phased plan into `docs/plans/`, each phase with a Verify line.
❌ If it starts editing files immediately: L1/L3 miss — the signal to climb the automation ladder (chapter 08).

## 2. Implementation — verification should close the loop

> the plan looks good, go ahead

✅ Implements phase by phase; runs each phase's Verify step; before declaring done, runs the verify-app subagent (eval gates + frontend build) and shows you *evidence* — test output, build exit — not just "done!"
❌ If it says "done" with no evidence: that's the classic gap — and the case for an L4 Stop hook.

## 3. A decision — log-decision should volunteer

> should timesheet rounding be per-entry or per-day? let's settle it: per-entry.

✅ Discusses, then *offers to log it* as the next D-number in `docs/research-and-planning.md` with the reasoning, and waits for your approval.
❌ If the decision stays in chat, it's lost to every future session — the exact failure the skill exists to prevent.

## 4. A mistake — learn should volunteer at wrap-up

Correct it on something real during any task (e.g., "no — never start a second uvicorn, one's already running"). Then:

> ok that's everything for today, wrap up

✅ Before finishing, proposes a 1–3 line gotcha entry (with the why and today's date) for `docs/gotchas/`, and waits for approval.
❌ If it wraps up without proposing anything after a real correction: the highest-value miss there is. Note it — two of these and we ship the Stop hook.

## Scorecard

| # | Fired on its own? |
|---|---|
| 1 research → plan | |
| 2 verify with evidence | |
| 3 decision offered | |
| 4 lesson offered | |

4/4 = the background layer works; use Claude normally. Anything less: each miss is a real observed failure — exactly the trigger the playbook needs to justify the next automation rung. Report it and we escalate that one spot.
