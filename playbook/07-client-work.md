# 07 — Client-facing work

Client engagements add a second stream of context: emails, meeting notes, approvals, scope changes. The playbook's rules extend to it unchanged — with one governing principle:

**Raw communications never enter standing context; only distillates do.**

A 40-email thread pasted into a session costs thousands of tokens and degrades attention every time. The distilled decision it contains costs ~100 tokens behind a pointer. Teams without a distillation habit end up pasting threads ad hoc — that's the expensive path, not this one.

## Where client context lives

| What | Where | Notes |
|---|---|---|
| Client decisions & approvals | `docs/decisions/NNNN-slug.md` | Same ADR log, with a **Source** line citing the communication |
| Client preferences, constraints, quirks | Per-client context file | Loads only when working on that client (below) |
| Open asks / action items | Tracker | Work state — never markdown (see [02](02-logging.md)) |
| Raw emails, notes, recordings | Email/Drive/CRM — *not the repo* | Retrieved on demand, never preloaded |

## Client decisions

Same mini-ADR format, plus a source reference so the exact wording is findable later:

> **Source:** Client approved scope cut — J. Smith email, 2026-07-14, "Re: Phase 2 scope"

The kit's `0000-client-template.md` adds this line. Log via `/log-decision` the moment an email or call settles something: approvals, scope changes, deadline shifts, "the client prefers X." This ends the "the client said something in some thread" archaeology — and protects you when scope is disputed, because the entry points at the evidence.

## Per-client context files

For a repo serving one client, client facts go in the normal CLAUDE.md/gotchas. For a monorepo or agency workspace serving many, use directory stacking — Claude Code pulls in child CLAUDE.md files only when working under that directory:

```
clients/
├── acme/
│   ├── CLAUDE.md      # stack, approval chain, "invoices via their portal only",
│   │                  # tone for deliverables, key contacts & roles
│   └── docs/…         # acme's decisions/, gotchas/
└── globex/
    └── CLAUDE.md
```

Working in `clients/acme/` loads Acme's context; everywhere else it costs zero. This is the knowledge-with-a-recall-trigger principle implemented with directory structure. Same standards apply: ≤ 60 lines, scar-tissue entries only, prune what nobody remembers the reason for.

## Raw communications: retrieve, don't preload

When you need the exact wording — a scope dispute, a quoted commitment — pull the specific message on demand via an email/CRM MCP or search, use it, and let it fall out of context. Connect comms tools read-only where possible, and never let session context accumulate whole threads "just in case."

The flow for a decision-heavy client email:

1. Email arrives → human (or an agent with inbox access) identifies it contains a decision.
2. `/log-decision` distills it: decision, consequences, source line.
3. The thread stays in the inbox. Future sessions read the 20-line ADR, not the thread.

## What not to do

- **A `client-notes.md` dumping ground** — undistilled meeting notes in the repo are markdown rot with a client label.
- **Preloading comms via MCP** — an email MCP that injects recent threads into every session inverts the whole model. On-demand fetch only.
- **Client PII in standing context** — contact details beyond name/role, contract values, credentials: keep them in the systems that hold them; retrieve when needed.
