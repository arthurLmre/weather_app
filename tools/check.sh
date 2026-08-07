#!/usr/bin/env bash

set -e

echo "🔍 Vérification du formatage..."
dart format --output=none --set-exit-if-changed

echo "🔎 Analyse du projet..."
flutter analyze

echo "🧪 Exécution des tests..."
flutter test