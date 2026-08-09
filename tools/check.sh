#!/usr/bin/env bash

set -e

if command -v fvm >/dev/null 2>&1; then
  DART_CMD="fvm dart"
  FLUTTER_CMD="fvm flutter"
else
  DART_CMD="dart"
  FLUTTER_CMD="flutter"
fi

echo "🔍 Vérification du formatage..."
$DART_CMD format \
  --output=none \
  --set-exit-if-changed \
  lib test

echo "🔎 Analyse du projet..."
$FLUTTER_CMD analyze

echo "🧪 Exécution des tests..."
$FLUTTER_CMD test