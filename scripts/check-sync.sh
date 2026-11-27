#!/usr/bin/env bash
# Fail when a product .cursor copy drifts from this toolkit.
set -euo pipefail

SOURCE="$(cd "$(dirname "$0")/.." && pwd)"

if [[ $# -ne 1 ]]; then
  echo "uso: scripts/check-sync.sh <raiz-do-produto>" >&2
  exit 1
fi

DEST="$(cd "$1" && pwd)"

diff -ru "$SOURCE/.cursor/rules" "$DEST/.cursor/rules"
diff -ru "$SOURCE/.cursor/skills" "$DEST/.cursor/skills"
diff -ru "$SOURCE/.cursor/hooks" "$DEST/.cursor/hooks"
diff -u "$SOURCE/.cursor/hooks.json" "$DEST/.cursor/hooks.json"
echo "cursor copy matches toolkit"
