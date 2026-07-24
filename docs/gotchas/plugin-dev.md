# Plugin development

> Plugin-shipped content must never unconditionally reference per-repo resources. The SessionStart hook told every session to "run the verify-app subagent," but verify-app only exists after /adopt scaffolds it — in non-adopted repos the policy pointed at a ghost. Anything the plugin says must either ship with the plugin or be conditionally checked at runtime (see hooks/session-start.sh). (2026-07, found by Ray, PR #1)

> Plugin installs are per-environment, not per-user: a user-scope install on a laptop is invisible to cloud/web sessions, which start in a fresh container with an empty ~/.claude. Repo-level `.claude/settings.json` (extraKnownMarketplaces + enabledPlugins) is the only thing that makes a plugin follow a *repo* across environments and teammates. (2026-07, Ray hit this in cloud sessions)

> Users patching their local plugin cache (~/.claude/plugins/cache/...) lose the patch on the next update — the fix must land in this repo to be durable. Ray patched his cache first; the PR was the right second step. Tell collaborators: cache edits are for testing, PRs are for fixing. (2026-07, PR #1)
