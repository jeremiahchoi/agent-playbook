# 05 — Token optimization

Context is the scarce resource: sessions start with 20–30k tokens of fixed overhead before you type anything, performance degrades as the window fills, and past ~150–200 always-loaded instructions the model starts dropping rules. Optimize in this order.

## 1. Move knowledge down the loading-cost hierarchy

| Tier | Loads | Put here |
|---|---|---|
| CLAUDE.md / unscoped rules | Always | Only what every session needs (≤ 60 lines) |
| Path-scoped rules | On matching files | Per-area conventions |
| Skills | Body on invocation only | Procedures, checklists |
| Docs behind pointers | When the task warrants | Gotchas, ADRs, deep references |
| Hooks | Never (runs outside context) | Everything enforceable |

Teams have measured ~40% cuts in fixed per-session cost just by moving conventions from CLAUDE.md into path-scoped rules and skills. The audit question for every line in an always-loaded file: *would removing this cause mistakes?*

## 2. Keep always-loaded files stable (cache economics)

Prompt caching rewards stable prefixes — Manus measured ~10x cost difference between cached and uncached context. Practical rules:

- CLAUDE.md changes should be rare, reviewed, and append-leaning. Churn is a real cost, not just noise.
- Append-only gotcha files are cache-friendly by construction.
- Don't dynamically rewrite standing instructions mid-project without reason.

## 3. Spend main-session context only on the task

- **Subagents for anything noisy** — codebase exploration, log analysis, dependency audits. They read hundreds of files in an isolated window and return a summary. This is the single biggest in-session saver.
- **Artifacts between phases** — a one-page research doc replaces thousands of lines of raw file reads in the next session (see [03](03-workflow.md)). Target 40–60% context utilization during active work.
- **`/clear` between unrelated tasks; restart after two failed corrections.** A clean session with a better prompt beats a long session full of failed approaches.
- **CLI tools over MCP servers where possible** (`gh`, `aws`, `sentry-cli`) — most MCP servers preload large tool schemas; CLIs cost nothing until invoked.
- **Prefer single-test commands** over full suites; pipe only relevant log excerpts, not whole files.

## 4. Two Manus lessons that look like waste but aren't

- **Leave errors in context.** Failed attempts and stack traces shift the model away from repeating the mistake. Don't tidy them away mid-session.
- **Recite goals on long tasks.** A todo list the agent keeps rewriting pushes the plan back into recent attention and prevents drift. (Claude Code's plan/task tracking does this; don't fight it.)

## 5. Prune on a cadence

Quarterly (or when the agent starts ignoring rules): audit CLAUDE.md and gotchas against the scar-tissue standard — delete lines whose originating failure nobody remembers, convert enforceable ones to hooks, demote rarely-needed ones to skills or docs. Bloated instruction files don't just cost tokens; they cause the instructions that matter to get lost.
