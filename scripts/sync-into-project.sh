#!/usr/bin/env bash
# Copy this repo's Cursor files into a product root.
set -euo pipefail

SOURCE="$(cd "$(dirname "$0")/.." && pwd)"

if [[ $# -ne 1 ]]; then
  echo "uso: scripts/sync-into-project.sh <raiz-do-produto>" >&2
  exit 1
fi

DEST="$(cd "$1" && pwd)"

if [[ "$DEST" == "$SOURCE" ]]; then
  echo "o destino é o próprio toolkit" >&2
  exit 1
fi

mkdir -p "$DEST/.cursor"
rm -rf "$DEST/.cursor/rules" "$DEST/.cursor/skills" "$DEST/.cursor/hooks"
mkdir -p "$DEST/.cursor/rules" "$DEST/.cursor/skills" "$DEST/.cursor/hooks"
cp -a "$SOURCE/.cursor/rules/." "$DEST/.cursor/rules/"
cp -a "$SOURCE/.cursor/skills/." "$DEST/.cursor/skills/"
cp -a "$SOURCE/.cursor/hooks/." "$DEST/.cursor/hooks/"
cp "$SOURCE/.cursor/hooks.json" "$DEST/.cursor/hooks.json"
chmod +x "$DEST/.cursor/hooks/model-cost-guard.py"
echo "synced $SOURCE/.cursor -> $DEST/.cursor"
