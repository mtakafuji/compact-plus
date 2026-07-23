#!/usr/bin/env bash
# Codex SessionStart(source=compact): inject the state saved by PreCompact.
# The built-in compact summary handles the immediate continuation; this hook
# restores compact-plus external state on the next turn.

set -uo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
COMPACT_PLUS_RECOVERY_EVENT=SessionStart \
  exec bash "$SCRIPT_DIR/userpromptsubmit-compaction-recovery.sh"
