#!/bin/bash
# SessionStart hook: export the current session id to CLAUDE_ENV_FILE so the
# /compact-plus skill (and any other in-session Bash call) can read it as
# $CLAUDE_CODE_SESSION_ID. Claude Code does not expose session_id as a Bash env
# var by default; hooks receive it only through the stdin JSON payload.
#
# fail-open (always exit 0)

set -uo pipefail

# Codex exports CODEX_THREAD_ID directly and does not use CLAUDE_ENV_FILE.
[[ -n "${PLUGIN_ROOT:-}" || "${COMPACT_PLUS_RUNTIME:-}" == "codex" ]] && exit 0

INPUT=$(cat)
SESSION_ID=$(printf '%s' "$INPUT" | jq -r '.session_id // empty' 2>/dev/null || true)

[[ -n "$SESSION_ID" ]] || exit 0
[[ -n "${CLAUDE_ENV_FILE:-}" ]] || exit 0

# Append (not overwrite) to preserve exports from other SessionStart hooks.
printf 'export CLAUDE_CODE_SESSION_ID=%s\n' "$SESSION_ID" >> "$CLAUDE_ENV_FILE" 2>/dev/null || true

exit 0
