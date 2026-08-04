#!/usr/bin/env bash

set -euo pipefail

# Toujours exécuter le script depuis la racine du dépôt.
cd "$(git rev-parse --show-toplevel)"

echo "🔍 Vérification du formatage..."
fvm dart format \
  --output=none \
  --set-exit-if-changed \
  lib test

echo "🔎 Analyse du projet..."
fvm flutter analyze

echo "🧪 Exécution des tests..."
fvm flutter test

echo "✅ Toutes les vérifications sont passées."