#!/bin/bash
BIN_DIR="$(pwd)/bin"
find . -type d \( -name "modrinth" -o -name "curseforge" \) -print0 | while IFS= read -r -d '' dir; do
    (
        cd "$dir" || exit 1
        case "${dir##*/}" in
            curseforge)
                packwiz cf export
                mv ./*.zip "$BIN_DIR/"
                ;;
            modrinth)
                packwiz mr export
                mv ./*.mrpack "$BIN_DIR/"
                ;;
        esac
    )
done