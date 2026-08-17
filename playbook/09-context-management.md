# 09 — Context management

Token optimization ([05](05-token-optimization.md)) is about what you *load*. Context management is about what happens to a session as it *runs* — and it's where most quality is silently lost. A session at 80% context produces measurably worse output than the same session at 30%, with the same prompt. That's context rot: the model still answers, it just gets quietly worse — forgetting earlier instructions, contradicting decisions, re-asking answered questions.

Anthropic names three techniques for long-horizon work. Use all three.

## 1. Compaction — with intent

Auto-compact fires around 83% of the window. **That's the failure mode, not the plan** — by then you've already spent time in the degraded zone, and the summary is written under duress.

- **Compact at natural breakpoints, around 60%** — after a feature lands, before starting the next thing. `/compact <instructions>` beats bare `/compact`: *"preserve the full list of modified files, the test commands, and the decisions we made; drop file contents and search results."*
- **What to preserve**: architectural decisions, unresolved bugs, implementation details, modified files. **What to drop**: raw tool outputs, file dumps, search results — anything already processed.
- **`/clear` beats `/compact`** when switching to unrelated work, or when context is corrupted by failed approaches. After two failed corrections on the same issue, clear and restart with a better prompt.
- Watch it with `/context` — it shows exactly where tokens went (system prompt, tools, memory files, skills, history). Run it when a session feels sluggish or forgetful.

## 2. Structured note-taking — the durable half

Compaction is lossy. Anything that must survive belongs in a file, not in the conversation. This is what the playbook's artifacts already are: research docs, plans with phase checkboxes, gotchas, decisions. The discipline: **write the note before you need it**, not after the context is gone.

`/agent-playbook:handoff` writes a `.claude/HANDOFF.md` — current state, what's done, what's next, files touched, decisions made, open threads — so a fresh session resumes in seconds. Use it before `/clear`, before compaction, and at the end of any session with unfinished work.

For long tasks, keep the plan file open and check phases off as you go. A plan that gets updated is a to-do list the agent re-reads; that recitation keeps the goal in recent attention and prevents drift.

## 3. Sub-agent architectures — spend someone else's context

A sub-agent burns tens of thousands of tokens exploring and returns 1,000–2,000 tokens of distilled findings. The detailed search context stays isolated; your main session gets the answer. This is the single biggest saver in practice: "use subagents to investigate X" instead of reading twenty files yourself.

## Choosing between them

| Situation | Technique |
|---|---|
| Long back-and-forth on one problem | Compaction with instructions |
| Iterative work with clear milestones | Note-taking (plans, handoff) |
| Broad research or parallel exploration | Sub-agents |
| Switching tasks entirely | `/clear` + handoff note |

## Automate the watching

Nobody remembers to check `/context` — and critically, **a session cannot perceive its own context usage**. Telling an agent "write a handoff at 70%" is asking it to react to an event it can't see; that policy silently never fires. Perception has to be injected:

- **A UserPromptSubmit hook** that measures the transcript on every message and injects a warning at 70%/85% — or 400k/700k tokens absolute, because 70% of a 1M window (700k) is long past where quality degrades. This works everywhere, including the desktop app.
- **A status-line script** keeps usage on screen — green under 50%, yellow 50–70%, red past 70%. Terminal CLI only: **the desktop app does not render status lines**, so treat it as a CLI perk, not the safety net.
- **A PreCompact hook** is the last line: whenever compaction fires (auto or manual), have it force the summary to preserve goal, state, file paths, decisions, and ruled-out approaches while dropping re-readable tool output.

Percentage thresholds assume a 200k window; on 1M-context models use the absolute floors instead. Never trust a tool that reports context without knowing the real window size.
