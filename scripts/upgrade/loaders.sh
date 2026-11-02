#!/usr/bin/env bash
set -euo pipefail

fabric_version=""
quilt_version=""

# Arguments (uses eza as format)
while [[ $# -gt 0 ]]; do
  HELP_USAGE="\033[1;4mUsage:\033[0m \033[1m$0\033[0m [OPTIONS]"
  case "$1" in
    -f|--fabric|--fabric-version)
      fabric_version="$2"
      shift 2
      ;;
    -q|--quilt|--quilt-version)
      quilt_version="$2"
      shift 2
      ;;
    '-?'|--help)
      echo -e "Upgrade loaders in modpacks

$HELP_USAGE

\033[1;4mOPTIONS:\033[0m
  \033[1m-?, --help\033[0m                                print help
  \033[1m-f, --fabric, --fabric-version\033[0m <VERSION>  migrate fabric loader
  \033[1m-q, --quilt, --quilt-version\033[0m <VERSION>    migrate quilt loader"
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

# Upgrade loaders
REPOSITORY=$(git rev-parse --show-toplevel)
find "$REPOSITORY/versions" -type f -name "pack.toml" -print0 | while IFS= read -r -d '' filepath; do
  dir=$(dirname "$filepath")

  IFS='/' read -ra parts <<< "${filepath#"$REPOSITORY/versions/"}"
  loader="${parts[0]}"

  (
    cd "$dir"
    
    # Skip Fabric & Quilt unless specified (to avoid issues with beta releases)
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

    # Skip if version is unspecified
    if [[ -z "$version" ]]; then
      exit 0
    fi

    # Skip on error
    if ! packwiz migrate loader "$version"; then
      echo "Skipping loader!"
      exit 1
    fi
  )
done