#!/usr/bin/env bash
set -euo pipefail

while [[ $# -gt 0 ]]; do
  case "$1" in
    '-?'|--help)
      echo -e "
\033[1;4mUsage:\033[0m $0 [OPTIONS]

\033[1;4mOPTIONS:\033[0m
  \033[1m-?, --help\033[0m  print help"
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
done

REPOSITORY=$(git rev-parse --show-toplevel)
find "$REPOSITORY/versions" -type f -name "pack.toml" -print0 | while IFS= read -r -d '' filepath; do
  dir=$(dirname "$filepath")
  (
    cd "$dir"
    IFS='/' read -ra parts <<< "${filepath#"$REPOSITORY/versions/"}"
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