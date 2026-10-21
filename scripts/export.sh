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
BIN="$REPOSITORY/bin"
if [[ -d "$BIN" ]]; then
  rm -r "$BIN"
fi
mkdir -p "$BIN"

find "$REPOSITORY/versions" -type f -name 'pack.toml' -print0 | while IFS= read -r -d '' filepath; do
  dir=$(dirname "$filepath")
  (
    cd "$dir"

    IFS='/' read -ra parts <<< "${filepath#"$REPOSITORY/versions/"}"
    loader="${parts[0]}"
    mc_version="${parts[1]}"
    distribution="${parts[2]}"
    
    case "$distribution" in
      curseforge)
        output=$(packwiz cf export)
        mv *.zip "$BIN"
        ;;
      modrinth)
        output=$(packwiz mr export)
        mv *.mrpack "$BIN"
        ;;
      *)
        echo "Unknown distribution: $distribution"
        exit 1
        ;;
    esac
    if [[ "$output" == *'Modpack exported to '* ]]; then
      echo "Modpack exported (mc${mc_version}.${loader})"
    fi
  )
done