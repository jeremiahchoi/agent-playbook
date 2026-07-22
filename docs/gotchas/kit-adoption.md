# Kit adoption

> Keep this repo/plugin lean — no demo or sample content in the tree. Demos, walkthroughs, and scratch material live in the gitignored `local/` folder. jj was explicit: lightweight beats illustrative. (2026-07, examples/ reverted same day it shipped)

> Retrofits hit repos with existing, working conventions — first real case: bee already had a decision log (D-numbers in docs/research-and-planning.md) and a 55-line scar-tissue CLAUDE.md. The kit must defer, not prescribe: /log-decision and /learn now check for an existing convention before using the kit's format. Never introduce a second system next to a working one. (2026-07, bee retrofit)

> Skill/agent descriptions are the auto-invocation trigger — write them for the *model*, not for a human reading a menu. "Run at the end of any session where…" reads fine but never fires; "Use PROACTIVELY, without being asked, when…" does. Users want the workflow to run in the background, not to memorize slash commands. (2026-07, jj feedback on bee)

> /adopt originally only handled *empty* placeholders — real pre-existing markdown (notes, TODOs, overlapping docs) stuck around untouched and cluttered adopted repos. Consolidation is now an explicit /adopt step: classify every md, merge to one canonical home per topic, migrate status items to the tracker, always with approval. (2026-07, jj feedback)

> Pointer stubs were the wrong default for retrofits — jj wants repos *standardized*: git mv docs into the playbook layout, merge duplicates, delete empties, then grep-and-fix every inbound reference (markdown links, CLAUDE.md, CI) so nothing dangles. Pointers only for externally-referenced paths; actively-used team conventions (bee's D-numbers) still win over forced migration. (2026-07, jj feedback superseding the earlier pointer rule from the bee retrofit)
