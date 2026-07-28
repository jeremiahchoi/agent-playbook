#!/usr/bin/env bash
# agent-playbook status line: shows that the workflow system is active, its
# version, and live context usage so you can compact/hand off before quality
# degrades. No dependencies beyond python3.
# NOTE: status lines render in the terminal CLI footer only — the desktop app
# does not display them. The plugin's UserPromptSubmit hook is what warns you
# about context there.
# Enable in .claude/settings.json:
#   "statusLine": { "type": "command", "command": "$CLAUDE_PROJECT_DIR/.claude/statusline.sh" }
CODE=$(cat <<'PY'
import json, os, sys

raw = sys.stdin.read()
try:
    data = json.loads(raw)
except Exception:
    data = {}

def g(path, default=None):
    cur = data
    for k in path.split("."):
        if not isinstance(cur, dict) or k not in cur:
            return default
        cur = cur[k]
    return cur

model = g("model.display_name") or "Claude"
cwd = g("workspace.current_dir") or ""
repo = os.path.basename(cwd) if cwd else "?"

home = os.path.expanduser("~")
plugin_dirs, ver, pct = [], "", None
try:
    inst = json.load(open(os.path.join(home, ".claude/plugins/installed_plugins.json")))
    for entry in inst.get("plugins", {}).get("agent-playbook@agent-playbook", []):
        if entry.get("installPath"):
            plugin_dirs.append(entry["installPath"])
except Exception:
    pass
plugin_dirs.append(os.path.join(home, ".claude/plugins/marketplaces/agent-playbook/plugins/agent-playbook"))

for d in plugin_dirs:
    try:
        ver = open(os.path.join(d, "VERSION")).read().strip()
        if ver:
            break
    except Exception:
        continue

# Reuse the plugin's shared measurement (handles 1M windows, clamps, infers).
for d in plugin_dirs:
    checker = os.path.join(d, "hooks/context-check.py")
    if os.path.isfile(checker):
        try:
            import subprocess
            out = subprocess.run([sys.executable, checker, "--badge"], input=raw,
                                 capture_output=True, text=True, timeout=5).stdout.strip()
            if out.endswith("%"):
                pct = int(out[:-1])
            break
        except Exception:
            break

# Fallback if the plugin isn't installed/updated: measure inline, same rules.
if pct is None:
    used = g("context.used_tokens")
    pct = g("context.percent_used")
    limit = g("context.max_tokens")
    if used is None:
        tp = g("transcript_path")
        if tp and os.path.isfile(tp):
            best = 0
            try:
                with open(tp, "rb") as f:
                    tail = f.read()[-300000:].decode("utf-8", "ignore")
                for line in tail.splitlines():
                    try:
                        u = json.loads(line).get("message", {}).get("usage", {})
                        best = max(best, u.get("input_tokens", 0)
                                   + u.get("cache_read_input_tokens", 0)
                                   + u.get("cache_creation_input_tokens", 0))
                    except Exception:
                        continue
            except Exception:
                best = 0
            used = best or None
    if not limit:
        limit = 1000000 if (used or 0) > 200000 else 200000
    if pct is None and used:
        pct = int(used * 100 / limit)
    if pct is not None:
        pct = max(0, min(100, int(pct)))

badge = f"📘 playbook v{ver}" if ver else "📘 playbook"

# Thresholds from playbook/09: <50 fine, 50-70 wrap up, >70 act now.
ctx = ""
if pct is not None:
    if pct >= 70:
        ctx = f" │ \033[31m🔴 ctx {pct}% — /compact or /agent-playbook:handoff now\033[0m"
    elif pct >= 50:
        ctx = f" │ \033[33m🟡 ctx {pct}% — wrap up this thread\033[0m"
    else:
        ctx = f" │ \033[32m🟢 ctx {pct}%\033[0m"

print(f"\033[36m{badge}\033[0m │ {repo} │ {model}{ctx}", end="")
PY
)
exec python3 -c "$CODE"
