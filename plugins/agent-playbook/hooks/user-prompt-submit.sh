#!/usr/bin/env bash
# UserPromptSubmit hook: on every user message, measure context and inject a
# warning if it's filling up. This is the alert that works in the desktop app —
# status lines don't render there, and a session cannot otherwise perceive its
# own context usage. Silent below thresholds.
exec python3 "$(dirname "$0")/context-check.py" --warn
