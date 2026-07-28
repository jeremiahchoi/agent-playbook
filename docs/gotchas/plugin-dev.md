# Plugin development

> A session cannot perceive its own context usage — there is no signal for it. Policy like "at 70%, write a handoff" is an instruction to react to an invisible event, and it silently never fires (jj hit 91% on a 1M window with no alert). Perception must be injected: a UserPromptSubmit hook that measures the transcript and prints a warning is the only thing that reliably works, and unlike a status line it works in the desktop app. (2026-07, v0.4.2)

> Never hardcode a 200k context limit — 1M-window models exist and the math produces nonsense (the status line reported "ctx 456%"). Take the limit from the payload when present, infer >200k usage as a 1M window, and always clamp 0–100. Percentage thresholds also need an absolute floor: 70% of 1M is 700k, far past where quality degrades. (2026-07, v0.4.2)

> The desktop app does not render custom status lines — only the terminal CLI footer shows them. In app sessions the context meter and version badge are invisible, so the model-side 📘 announcements and the PreCompact hook are the primary indicator/safety there, not the status line. Don't promise users an always-on meter in the app. (2026-07, jj's session discovered it after we shipped the status line)

> Plugin-shipped content must never unconditionally reference per-repo resources. The SessionStart hook told every session to "run the verify-app subagent," but verify-app only exists after /adopt scaffolds it — in non-adopted repos the policy pointed at a ghost. Anything the plugin says must either ship with the plugin or be conditionally checked at runtime (see hooks/session-start.sh). (2026-07, found by Ray, PR #1)

> Plugin installs are per-environment, not per-user: a user-scope install on a laptop is invisible to cloud/web sessions, which start in a fresh container with an empty ~/.claude. Repo-level `.claude/settings.json` (extraKnownMarketplaces + enabledPlugins) is the only thing that makes a plugin follow a *repo* across environments and teammates. (2026-07, Ray hit this in cloud sessions)

> Users patching their local plugin cache (~/.claude/plugins/cache/...) lose the patch on the next update — the fix must land in this repo to be durable. Ray patched his cache first; the PR was the right second step. Tell collaborators: cache edits are for testing, PRs are for fixing. (2026-07, PR #1)
