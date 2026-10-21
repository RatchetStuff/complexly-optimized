#!/usr/bin/env bash
set -euo pipefail

find versions -type f -name "pack.toml" -print0 | while IFS= read -r -d '' filepath; do
  dir=$(dirname "$filepath")
  (
    cd "$dir"
    attempt=0
    while true; do
      ((attempt++))
      output=$(packwiz update -ay)
      echo "$output"

      if [[ "$output" != *'Failed to check updates for '* ]]; then
        break
      fi

      echo "Update check failed! Retrying..."
      sleep $((5 * attempt))
    done
  )
done