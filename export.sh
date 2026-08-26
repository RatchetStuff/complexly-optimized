#!/bin/bash
TOPLEVEL="$(git rev-parse --show-toplevel)"
cd $TOPLEVEL || exit 1
rm -r bin
mkdir -p bin/curseforge bin/modrinth
find versions -type f -name "pack.toml" | while read -r filepath; do
    DIR=$(dirname "$filepath")
    DISTRIBUTION=$(basename "$DIR")
    (
        cd "$DIR" || exit 1
        case "$DISTRIBUTION" in
        curseforge)
            packwiz cf export
            mv *.zip "$TOPLEVEL/bin/curseforge"
            ;;
        modrinth)
            packwiz mr export
            mv *.mrpack "$TOPLEVEL/bin/modrinth"
            ;;
        esac
    )
done