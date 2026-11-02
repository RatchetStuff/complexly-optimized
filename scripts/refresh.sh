#!/usr/bin/env bash
set -euo pipefail

REPOSITORY=$(git rev-parse --show-toplevel)
find "$REPOSITORY/versions" -type f -name 'pack.toml' -print0 | while IFS= read -r -d '' filepath; do
  dir=$(dirname "$filepath")
  (
    cd "$dir"
    packwiz refresh
  )
done