# 03 — The core workflow: research → plan → implement

For any task you couldn't describe as a one-sentence diff, split the work into three phases, each producing a compact artifact the next phase starts from (HumanLayer's pattern; also Anthropic's recommended explore → plan → code loop).

Why: agents fail most expensively by solving the wrong problem with a full context window. Artifacts let you review and correct a one-page document instead of babysitting a 200k-token session — and they're what teammates can actually pick up.

## Phase 1 — Research (`/research`)

Fresh session, plan mode. The agent explores the codebase — using **subagents** for the noisy reading so raw file contents never hit the main context — and writes `docs/research/YYYY-MM-DD-topic.md`:

- The question/task
- Summary answer up top
- Relevant files with one line each on why they matter
- How the flow works (prose, not pasted code)
- Constraints and prior decisions found (link ADRs)
- Open questions

Human reviews one page. Wrong assumptions die here, where they're cheap.

## Phase 2 — Plan (`/plan`)

Fresh session reads the research doc and writes `docs/plans/YYYY-MM-DD-feature.md`:

- Goal, linked research
- Phases, each with: steps, files to change, and **how to verify that phase** (exact commands/checks)
- Out of scope (explicitly)

This is the highest-leverage review moment on the team. A staff engineer reviewing a plan for 10 minutes beats reviewing a 2,000-line PR for an hour. Boris Cherny's team goes further: one Claude drafts the plan, a second reviews it "as a staff engineer" before any code.

## Phase 3 — Implement

Fresh session, out of plan mode: "implement `docs/plans/...md`, phase by phase, running each phase's verification before moving on." The plan's checks close the loop (see [04 — Verification](04-verification.md)). Finish with commit + PR referencing the plan.

## Session hygiene along the way

- **Scope investigations or subagent them** — "use subagents to investigate X" keeps exploration out of your main context.
- **Course-correct early; after two failed corrections, restart.** `/clear` and write a better prompt incorporating what you learned. Anthropic's internal teams: revert and restart beats wrestling a polluted context.
- **`/clear` between unrelated tasks.** The kitchen-sink session is the most common failure pattern.
- **For big features, let the agent interview you first** ("interview me in detail using AskUserQuestion, then write a spec") — then execute the spec in a fresh session.

## When to skip all this

If you could describe the diff in one sentence — typo, log line, rename — just ask for it directly. Planning overhead is for uncertain approaches, multi-file changes, and unfamiliar code.

## Scaling up

Once one loop works: parallel sessions in separate worktrees (Cherny runs 5 local + 5–10 web), writer/reviewer pairs (a fresh context reviews with no bias toward code it just wrote), and `claude -p` fan-out for mechanical migrations. Keep an agent busy during your gaps — Hashimoto's rule: "if I'm coding, I want an agent planning; if they're coding, I want to be reviewing."
