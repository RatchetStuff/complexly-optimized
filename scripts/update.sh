#!/usr/bin/env bash
set -euo pipefail

find versions -type f -name "pack.toml" -print0 | while IFS= read -r -d '' filepath; do
  dir=$(dirname "$filepath")
  (
    cd "$dir"
    IFS='/' read -ra parts <<< "${filepath#versions/}"
    loader="${parts[0]}"
    mc_version="${parts[1]}"
    
    attempt=0
    while true; do
      ((++attempt))
      output=$(packwiz update -ay)

      if [[ "$output" != *'Failed to check updates for '* ]]; then
        if [[ "$output" == *'All files are up to date!'* ]]; then
          echo "All files are up to date! (mc${mc_version}.${loader})"
        elif [[ "$output" == *'Files updated!'* ]]; then
          echo "Files updated! (mc${mc_version}.${loader})"
        fi
        break
      fi

      echo "Update check failed! Retrying... (attempt $attempt)"
      sleep $((5 * attempt))
    done
  )
done