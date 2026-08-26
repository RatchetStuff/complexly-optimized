#!/bin/bash
TOPLEVEL="$(git rev-parse --show-toplevel)"
cd $TOPLEVEL || exit 1
find versions -type f -name "pack.toml" | while read -r filepath; do
    DIR=$(dirname "$filepath")
    DISTRIBUTION=$(basename "$DIR")
    (
        cd "$DIR" || exit 1
        packwiz refresh
    )
done