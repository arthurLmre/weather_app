#!/usr/bin/env bash

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

echo "🚦 Vérifications avant commit..."

echo "🔍 Vérification du formatage..."
fvm dart format \
  --output=none \
  --set-exit-if-changed \
  lib test

echo "🔎 Analyse du projet..."
fvm flutter analyze

echo "✅ Commit autorisé."