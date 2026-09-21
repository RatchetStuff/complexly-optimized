#!/usr/bin/env bash
set -euo pipefail

TOPLEVEL=$(git rev-parse --show-toplevel)
BIN="$TOPLEVEL/bin"
if [[ -d "$BIN" ]]; then
  rm -r "$BIN"
fi
mkdir -p "$BIN"

find "$TOPLEVEL/versions" -type f -name "pack.toml" -print0 | while IFS= read -r -d '' filepath; do
  dir=$(dirname "$filepath")
  distribution="$(basename "$dir")"
  (
    cd "$dir"
    case "$distribution" in
      curseforge)
        packwiz cf export
        mv *.zip "$BIN"
        ;;
      modrinth)
        packwiz mr export
        mv *.mrpack "$BIN"
        ;;
      *)
        echo "Unknown distribution: $distribution"
        exit 1
        ;;
    esac
  )
done