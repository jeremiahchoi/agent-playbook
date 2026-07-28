#!/usr/bin/env python3
"""Shared context measurement for agent-playbook hooks and status line.

Reads a Claude Code hook/statusline JSON payload on stdin and reports how full
the context window is. Used by user-prompt-submit.sh (injects a warning into
the conversation — works in the desktop app, unlike a status line) and by the
kit status line.

Modes:
  --warn    print a warning line only when a threshold is crossed (else nothing)
  --badge   print "N%" or nothing, for status line composition
"""
import json
import os
import sys

# Percentage thresholds, plus an absolute floor: on a 1M window, 70% is 700k —
# far past where quality degrades. Warn by ~400k regardless of denominator.
NUDGE_PCT, URGENT_PCT = 70, 85
NUDGE_ABS, URGENT_ABS = 400_000, 700_000


def load():
    try:
        return json.load(sys.stdin)
    except Exception:
        return {}


def dig(data, path, default=None):
    cur = data
    for key in path.split("."):
        if not isinstance(cur, dict) or key not in cur:
            return default
        cur = cur[key]
    return cur


def transcript_tokens(path):
    """Highest input+cache token count in the recent transcript tail."""
    if not path or not os.path.isfile(path):
        return None
    best = 0
    try:
        with open(path, "rb") as fh:
            tail = fh.read()[-300_000:].decode("utf-8", "ignore")
    except Exception:
        return None
    for line in tail.splitlines():
        try:
            usage = json.loads(line).get("message", {}).get("usage", {})
        except Exception:
            continue
        if not isinstance(usage, dict):
            continue
        best = max(best, (usage.get("input_tokens", 0)
                          + usage.get("cache_read_input_tokens", 0)
                          + usage.get("cache_creation_input_tokens", 0)))
    return best or None


def measure(data):
    """Return (used_tokens, limit, percent) with any piece possibly None."""
    limit = dig(data, "context.max_tokens")
    used = dig(data, "context.used_tokens")
    pct = dig(data, "context.percent_used")

    if used is None:
        used = transcript_tokens(dig(data, "transcript_path"))

    # Infer the window when it isn't reported: usage past 200k means the
    # session is on a large-context model, so don't assume the 200k default.
    if not limit:
        if used and used > 200_000:
            limit = 1_000_000
        elif pct and used:
            limit = int(used * 100 / pct) if pct else 200_000
        else:
            limit = 200_000

    if pct is None and used:
        pct = int(used * 100 / limit)
    if pct is not None:
        pct = max(0, min(100, int(pct)))  # never print nonsense like 456%
    return used, limit, pct


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else "--warn"
    used, _limit, pct = measure(load())
    if pct is None:
        return

    if mode == "--badge":
        print(f"{pct}%", end="")
        return

    urgent = pct >= URGENT_PCT or (used or 0) >= URGENT_ABS
    nudge = pct >= NUDGE_PCT or (used or 0) >= NUDGE_ABS
    tokens = f"{used:,} tokens, " if used else ""
    if urgent:
        print(f"⚠️ agent-playbook: context is {pct}% full ({tokens}quality degrades from here). "
              "Use the handoff skill NOW to write .claude/HANDOFF.md, then tell the user to /clear "
              "and resume with 'read .claude/HANDOFF.md and continue'.")
    elif nudge:
        print(f"⚠️ agent-playbook: context is {pct}% full ({tokens}approaching the degraded zone). "
              "Finish the current thread, then use the handoff skill before starting anything new.")


if __name__ == "__main__":
    main()
