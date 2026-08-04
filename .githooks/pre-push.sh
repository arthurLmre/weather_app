#!/usr/bin/env bash

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

echo "🚦 Vérifications avant push..."

./tool/check.sh

echo "✅ Push autorisé."