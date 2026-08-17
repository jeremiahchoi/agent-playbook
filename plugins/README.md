# plugins/ — deprecated

**Do not adopt this. Copy [`kit/`](../kit/) into your repo instead.**

This directory serves the workflows as a Claude Code plugin (`/learn`, `/log-decision`, `/research`, `/plan`, `/adopt`, `/pulse`, and a code-simplifier agent). It is kept published so existing installs keep resolving — nothing more.

## Why it was retired

- The workflow is instructions, not machinery — a competent agent does the steps when simply told to, so the skills were automating something the `CLAUDE.md` text already achieves.
- Plugin installs are per-environment, so a user-scope install on a laptop silently went missing in cloud and CI sessions.
- Pinning a marketplace made every adopting repo depend on this one, and skills that vanish on uninstall leave instructions pointing at commands that no longer exist.

## If you already have it installed

- Nothing breaks by leaving it. To remove it: drop `extraKnownMarketplaces` and the `agent-playbook@agent-playbook` entry from the repo's `.claude/settings.json`.
- Check for a second enabled plugin before deleting `enabledPlugins` wholesale — removing the whole key disables those too.
- Then reword any docs that tell agents to run the slash commands; the practice stays, only the invocation goes.
