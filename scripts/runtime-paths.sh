#!/usr/bin/env bash

# Shared runtime and storage paths for Claude Code and Codex hooks.
# COMPACT_PLUS_RUNTIME is an explicit test/debug override. Codex plugin hooks
# set PLUGIN_ROOT; Claude Code plugin hooks only set CLAUDE_PLUGIN_ROOT.

if [[ -n "${COMPACT_PLUS_RUNTIME:-}" ]]; then
  COMPACT_PLUS_RUNTIME_NAME="$COMPACT_PLUS_RUNTIME"
elif [[ -n "${PLUGIN_ROOT:-}" ]]; then
  COMPACT_PLUS_RUNTIME_NAME="codex"
else
  COMPACT_PLUS_RUNTIME_NAME="claude"
fi

case "$COMPACT_PLUS_RUNTIME_NAME" in
  codex)
    COMPACT_PLUS_STATE_DIR="${TMPDIR:-/tmp}/codex-compact-state" # lint:allow-os-tmp
    COMPACT_PLUS_OFFSET_DIR="${TMPDIR:-/tmp}/codex-compact-state-offset" # lint:allow-os-tmp
    COMPACT_PLUS_COUNTER_DIR="${TMPDIR:-/tmp}/codex-compact-state-counter" # lint:allow-os-tmp
    COMPACT_PLUS_MARKER_DIR="${TMPDIR:-/tmp}/codex-compacted" # lint:allow-os-tmp
    COMPACT_PLUS_WARN_DIR="${TMPDIR:-/tmp}/codex-compact-warn" # lint:allow-os-tmp
    COMPACT_PLUS_WARNED_DIR="${TMPDIR:-/tmp}/codex-compact-warned" # lint:allow-os-tmp
    COMPACT_PLUS_PLAN_POINTER_DIR="${TMPDIR:-/tmp}/codex-active-plan" # lint:allow-os-tmp
    COMPACT_PLUS_BACKUP_DIR="${CODEX_HOME:-${HOME}/.codex}/backups/transcripts"
    ;;
  claude|*)
    COMPACT_PLUS_RUNTIME_NAME="claude"
    COMPACT_PLUS_STATE_DIR="${TMPDIR:-/tmp}/claude-compact-state" # lint:allow-os-tmp
    COMPACT_PLUS_OFFSET_DIR="${TMPDIR:-/tmp}/claude-compact-state-offset" # lint:allow-os-tmp
    COMPACT_PLUS_COUNTER_DIR="${TMPDIR:-/tmp}/claude-compact-state-counter" # lint:allow-os-tmp
    COMPACT_PLUS_MARKER_DIR="${TMPDIR:-/tmp}/claude-compacted" # lint:allow-os-tmp
    COMPACT_PLUS_WARN_DIR="${TMPDIR:-/tmp}/claude-compact-warn" # lint:allow-os-tmp
    COMPACT_PLUS_WARNED_DIR="${TMPDIR:-/tmp}/claude-compact-warned" # lint:allow-os-tmp
    COMPACT_PLUS_PLAN_POINTER_DIR="${TMPDIR:-/tmp}/claude-active-plan" # lint:allow-os-tmp
    COMPACT_PLUS_BACKUP_DIR="${HOME}/.claude/backups/transcripts"
    ;;
esac

export COMPACT_PLUS_RUNTIME_NAME
export COMPACT_PLUS_STATE_DIR
export COMPACT_PLUS_OFFSET_DIR
export COMPACT_PLUS_COUNTER_DIR
export COMPACT_PLUS_MARKER_DIR
export COMPACT_PLUS_WARN_DIR
export COMPACT_PLUS_WARNED_DIR
export COMPACT_PLUS_PLAN_POINTER_DIR
export COMPACT_PLUS_BACKUP_DIR
