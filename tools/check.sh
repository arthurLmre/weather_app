#!/usr/bin/env bash

set -e

echo "🔍 Vérification du formatage..."
dart format \
  --output=none \
  --set-exit-if-changed \
  lib test

echo "🔎 Analyse du projet..."
flutter analyze

echo "🧪 Exécution des tests..."
flutter test