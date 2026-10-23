#!/usr/bin/env bash
set -euo pipefail

fabric_version=""
quilt_version=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -f|--fabric-version)
      fabric_version="$2"
      shift 2
      ;;
    -q|--quilt-version)
      quilt_version="$2"
      shift 2
      ;;
    '-?'|--help)
      echo -e "
\033[1;4mUsage:\033[0m $0 [OPTIONS]

\033[1;4mOPTIONS:\033[0m
  \033[1m-?, --help\033[0m                      print help
  \033[1m-f, --fabric-version\033[0m <VERSION>  migrate fabric loader
  \033[1m-q, --quilt-version\033[0m <VERSION>   migrate quilt loader"
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

  IFS='/' read -ra parts <<< "${filepath#"$REPOSITORY/versions/"}"
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

    if ! packwiz migrate loader "$version"; then
      echo "Skipping loader!"
      exit 1
    done
  )
done