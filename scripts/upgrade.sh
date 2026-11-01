#!/usr/bin/env bash
set -euo pipefail

REPOSITORY=$(git rev-parse --show-toplevel)
"$REPOSITORY"/scripts/upgrade/loaders.sh
"$REPOSITORY"/scripts/upgrade/mods.sh