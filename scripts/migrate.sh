#!/usr/bin/env bash
set -euo pipefail

fabric_version="0.19.5"
quilt_version="0.30.1"

find versions -type f -name "pack.toml" -print0 | while IFS= read -r -d '' filepath; do
  dir=$(dirname "$filepath")

  IFS='/' read -ra parts <<< "${filepath#versions/}"
  loader="${parts[0]}"

  (
    cd "$dir"
    case "$loader" in
      fabric)
        version="$fabric_version"
        ;;
      quilt)
        version="$quilt_version"
        ;;
      *)
        version='latest'
        ;;
    esac

    if [[ -z "$version" ]]; then
      exit 0
    fi

    attempt=0
    until packwiz migrate loader "$version"; do
      ((++attempt))
      echo "Migration failed! Retrying... (attempt $attempt)"
      sleep $((5 * attempt))
    done
  )
done