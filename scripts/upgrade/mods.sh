#!/usr/bin/env bash
set -euo pipefail

# Arguments (uses eza as format)
while [[ $# -gt 0 ]]; do
  HELP_USAGE="\033[1;4mUsage:\033[0m \033[1m$0\033[0m [OPTIONS]"
  case "$1" in
    '-?'|--help)
      echo -e "Upgrade mods in modpacks

$HELP_USAGE

\033[1;4mOPTIONS:\033[0m
  \033[1m-?, --help\033[0m  print help"
      exit 0
      ;;
    *)
      echo -e "\033[1;31merror:\033[0m unexpected argument '\033[33m$1\033[0m' found

$HELP_USAGE

For more information, try '\033[1m--help\033[0m'."
      exit 1
      ;;
  esac
done

# Upgrade mods
REPOSITORY=$(git rev-parse --show-toplevel)
find "$REPOSITORY/versions" -type f -name "pack.toml" -print0 | while IFS= read -r -d '' filepath; do
  dir=$(dirname "$filepath")
  (
    cd "$dir"

    # Find metadata
    IFS='/' read -ra parts <<< "${filepath#"$REPOSITORY/versions/"}"
    loader="${parts[0]}"
    minecraft="${parts[1]}"
    
    attempt=0
    while true; do
      # Increment attempt count ('++attempt', not 'attempt++' to avoid error)
      ((++attempt))
      output=$(packwiz update -ay)

      if [[ "$output" != *'Failed to check updates for '* ]]; then
        if [[ "$output" == *'All files are up to date!'* ]]; then
          # Example: All files are up to date! (mc1.20.1.fabric)
          echo "All files are up to date! (mc${minecraft}.${loader})"
        elif [[ "$output" == *'Files updated!'* ]]; then
          # Example: Files updated! (mc1.20.1.fabric)
          echo "Files updated! (mc${minecraft}.${loader})"
        fi
        break
      fi

      # Retry on fail
      echo "Update check failed! Retrying... (attempt $attempt)"
      sleep $((5 * attempt))
    done
  )
done