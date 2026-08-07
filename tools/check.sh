#!/usr/bin/env bash

set -e

echo "🔍 Vérification du formatage..."
fvm dart format \
  --output=none \
  --set-exit-if-changed \
  lib test

echo "🔎 Analyse du projet..."
fvm flutter analyze

echo "🧪 Exécution des tests..."
fvm flutter test