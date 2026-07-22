# Philosophy & Sources

The living research doc behind this playbook. Every recommendation in `playbook/` and every file in `kit/` should trace back to a principle here, and every principle traces to a source or a real observed failure.

**How to update this doc:** when new research or experience changes our thinking — (1) add the source to the Source Library with today's date and what we took from it, (2) update or add the affected principle, (3) update the affected playbook chapters and kit files, (4) log a decision in `docs/decisions/` if the change reverses a prior position.

---

## Core principles

### 1. Context is the scarce resource

LLM performance degrades as the context window fills, and always-loaded files are paid for every session. Design knowledge in layers: a tiny always-loaded core (CLAUDE.md ≤ ~60 lines) that points to deeper docs loaded only when relevant (path-scoped rules, skills, on-demand doc reads). Past ~150–200 lines of always-on instructions, models start dropping rules.

*Backed by:* Anthropic best practices, alexop.dev progressive disclosure, Zenn loading-cost analysis (~40% fixed context cost cut by moving conventions out of CLAUDE.md).

### 2. Compounding: every mistake becomes a permanent lesson

The differentiator among elite setups is not file structure — it's that knowledge capture is **automated and event-driven**. Every agent mistake ends as a CLAUDE.md line, gotcha entry, hook, or test. No correction happens only in chat. Boris Cherny's team automates this from code review (`@.claude` PR tags commit corrections to CLAUDE.md); the "compound engineering" school frames it as: every unit of work must make the next unit easier.

*Backed by:* Boris Cherny's published workflow, Every/Cora compound engineering, Anthropic internal teams ("the better teams documented, the better Claude Code performed").

### 3. Verification is the biggest quality lever

Give the agent a check it can run itself — tests, build exit codes, lint, screenshot diffs — and the loop closes without a human. The creator of Claude Code calls verification "the most important thing to get great results," worth 2–3x output quality. Worth more than any documentation practice.

*Backed by:* Boris Cherny, Anthropic best practices ("give Claude a way to verify its work").

### 4. Knowledge compounds in markdown; work state rots in markdown

Split them. Decisions, lessons, and conventions belong in prose files — they compound. Tasks, plans-in-flight, status, and dependencies belong in a structured, queryable tracker (GitHub Issues via `gh`, or Beads for long-horizon agent work). Agents left to log status in markdown produce "hundreds of useless plan files."

*Backed by:* Steve Yegge / Beads (built after watching markdown plan-file proliferation kill a project).

Corollary for client-facing work: raw communications (email threads, meeting notes) are work-state-like — they never enter standing context. Only distillates compound: decisions with source references, per-client context files. Raw comms stay in email/CRM and are retrieved on demand.

### 5. Docs earn their place through real failures (the scar-tissue standard)

An entry in a gotchas file or CLAUDE.md must trace to a real observed failure or hard-won discovery — not aspiration. Mitchell Hashimoto's AGENTS.md: "each line represents a past agent failure that's now prevented." This is the pruning criterion that keeps context files lean and trusted.

*Backed by:* Mitchell Hashimoto (Ghostty), Anthropic best practices ("would removing this cause Claude to make mistakes? If not, cut it").

### 6. If a tool can enforce it, don't write prose about it

Style rules go to linters/formatters/hooks, not instructions. Hooks are deterministic; CLAUDE.md is advisory. Prose spent on things ESLint could catch is context spent for nothing.

*Backed by:* alexop.dev, Anthropic best practices (hooks), GitHub 2,500-repo AGENTS.md analysis.

### 7. Artifacts over conversations

Long work moves through compact, reviewable markdown artifacts: research → plan → implement, each phase writing a document the next phase (or a teammate, or a fresh session) starts from. You review a 300-line plan instead of babysitting a 200k-token session. Target 40–60% context utilization during active work.

*Backed by:* HumanLayer ACE-FCA, Anthropic best practices (explore → plan → implement), Cognition Session Insights.

### 8. Stability is a token optimization

Prompt/KV caching rewards stable, append-only context: Manus measured ~10x cost difference between cached and uncached prefixes. Keep always-loaded files stable (change rarely, append rather than churn). Also from Manus: keep errors visible in context so the model stops repeating them; recite goals (todo recitation) on long tasks to prevent drift.

*Backed by:* Manus context-engineering lessons.

### 9. Everything in git

Team config is code: `.claude/skills/`, `.claude/agents/`, `settings.json` permission allowlists, hooks, CLAUDE.md. Checked in, reviewed like code, uniform across the team. Universal across every elite setup studied.

*Backed by:* Boris Cherny, Anthropic internal teams, AGENTS.md standard.

### 10. Knowledge should carry its own recall trigger

The best knowledge systems store *when to recall* alongside *what to know* (Cognition's Knowledge items = content + semantic trigger). In Claude Code terms: path-scoped rules fire on matching files, skill descriptions gate skill bodies, CLAUDE.md pointers say "read docs/X before doing Y." Never dump knowledge where it loads unconditionally unless it's needed unconditionally.

*Backed by:* Cognition/Devin knowledge system, Claude Code rules/skills loading model.

---

## Source library

| Date reviewed | Source | Who/what | What we took |
|---|---|---|---|
| 2026-07-21 | [Claude Code best practices](https://code.claude.com/docs/en/best-practices) | Anthropic official docs | Lean CLAUDE.md include/exclude table, verification loops, explore→plan→implement, subagents for research, /clear discipline, failure patterns |
| 2026-07-21 | [How Anthropic teams use Claude Code](https://claude.com/blog/how-anthropic-teams-use-claude-code) | Anthropic internal teams | Documentation quality ↔ agent performance; slash-command-heavy teams; plan in chat, execute in Code; revert-and-restart over wrestling |
| 2026-07-21 | [Boris Cherny's workflow](https://howborisusesclaudecode.com/) + [Slashdot summary](https://developers.slashdot.org/story/26/01/06/2239243/creator-of-claude-code-reveals-his-workflow) | Creator of Claude Code | Mistake→CLAUDE.md ritual, @.claude PR-review capture, verification = 2–3x quality, everything in git, parallel sessions, "surprisingly vanilla" |
| 2026-07-21 | [Steering Claude Code](https://claude.com/blog/steering-claude-code-skills-hooks-rules-subagents-and-more) | Anthropic | CLAUDE.md vs rules vs skills vs hooks vs subagents loading behavior and costs |
| 2026-07-21 | [HumanLayer ACE-FCA](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/ace-fca.md) | HumanLayer | Research→plan→implement artifact chain, thoughts/ directory, frequent intentional compaction, 40–60% context target |
| 2026-07-21 | [Progressive disclosure for CLAUDE.md](https://alexop.dev/posts/stop-bloating-your-claude-md-progressive-disclosure-ai-coding-tools/) | alexop.dev | 50-line CLAUDE.md + docs/gotchas pattern, /learn skill, "if a tool can enforce it, don't write prose" |
| 2026-07-21 | [Lessons from 2,500+ AGENTS.md files](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/) | GitHub | Commands early with flags, one real snippet > three paragraphs, three-tier boundaries (always/ask/never), stack versions |
| 2026-07-21 | [Rules vs CLAUDE.md loading costs](https://zenn.dev/yottayoshida/articles/claude-code-context-cost-structure?locale=en) | Community measurement | Token-cost hierarchy; ~40% fixed-cost reduction via path-scoped rules/skills |
| 2026-07-21 | [Mitchell Hashimoto's workflow](https://newsletter.pragmaticengineer.com/p/mitchell-hashimoto) | Ghostty / HashiCorp founder | Scar-tissue AGENTS.md standard; always have an agent running; only ship code you understand |
| 2026-07-21 | [Introducing Beads](https://steveyegge.spicytakes.org/post/2025-11-12-introducing-beads-a-coding-agent-memory-system) | Steve Yegge | Markdown-rot failure mode; structured git-backed tracker for work state |
| 2026-07-21 | [How Cognition uses Devin to build Devin](https://cognition.com/blog/how-cognition-uses-devin-to-build-devin) + [Agents 101](https://devin.ai/agents101) | Cognition | Knowledge = content + semantic trigger; playbooks for recurring work; auto session insights |
| 2026-07-21 | [Manus context engineering](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus) | Manus | KV-cache stability (~10x), filesystem as memory, todo recitation, keep errors in context |
| 2026-07-21 | [Compound Engineering](https://every.to/guides/compound-engineering) | Every / Cora (Kieran Klaassen) | Every PR review teaches the system; every bug becomes a prevention system |
| 2026-07-21 | [AGENTS.md standard](https://agents.md/) | Linux Foundation / multi-vendor | Cross-tool instruction file format; symlink CLAUDE.md ↔ AGENTS.md |
| 2026-07-21 | [How AI coding agents use ADRs](https://mnemehq.com/insights/how-ai-coding-agents-use-adrs/) | Mneme | ADRs as machine-readable constraints agents check and propose |
| 2026-07-21 | [Scaling an agency with Claude Code](https://databar.ai/blog/article/how-to-scale-your-agency-with-claude-code) | Databar | Per-client context files that compound per engagement |
| 2026-07-21 | [Context inheritance for multi-client projects](https://www.mindstudio.ai/blog/context-inheritance-claude-code-multi-client-projects) | MindStudio | Directory-stacked CLAUDE.md as per-client recall trigger |
| 2026-07-21 | [Agent mail MCP](https://composio.dev/toolkits/agent_mail/framework/claude-code) + [AgentMail](https://www.agentmail.to/insights/email-ai-agent) | Composio / AgentMail | Fetch-specific-message-by-ID pattern; comms retrieved on demand, never preloaded |

---

## Watchlist (re-research periodically)

- **Beads adoption** — does the structured-tracker approach become standard for team agent work, or do issue trackers (Linear/GitHub) grow agent-native features that cover it?
- **Agent teams / multi-session orchestration** — Anthropic's agent-teams feature is young; team-level patterns not yet settled.
- **Auto-generated wikis** (DeepWiki-style) — whether auto-indexed codebase wikis beat hand-curated gotchas files at scale.
- **Cross-tool convergence** — AGENTS.md stewardship under the Linux Foundation; watch for skills/rules equivalents standardizing across Cursor/Codex/Copilot.
