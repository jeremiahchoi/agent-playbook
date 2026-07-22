# Kit adoption

> Keep this repo/plugin lean — no demo or sample content in the tree. Demos, walkthroughs, and scratch material live in the gitignored `local/` folder. jj was explicit: lightweight beats illustrative. (2026-07, examples/ reverted same day it shipped)

> Retrofits hit repos with existing, working conventions — first real case: bee already had a decision log (D-numbers in docs/research-and-planning.md) and a 55-line scar-tissue CLAUDE.md. The kit must defer, not prescribe: /log-decision and /learn now check for an existing convention before using the kit's format. Never introduce a second system next to a working one. (2026-07, bee retrofit)

> Skill/agent descriptions are the auto-invocation trigger — write them for the *model*, not for a human reading a menu. "Run at the end of any session where…" reads fine but never fires; "Use PROACTIVELY, without being asked, when…" does. Users want the workflow to run in the background, not to memorize slash commands. (2026-07, jj feedback on bee)

> Repos accumulate empty placeholder docs (bee: docs/decisions.md and docs/lessons.md, both 0 bytes, both bypassed by the real convention). During retrofit, convert them to pointers at the live location — deleting them invites someone to recreate them; leaving them empty invites a duplicate log. (2026-07, bee retrofit)
