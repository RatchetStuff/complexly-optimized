#!/bin/bash
find . -type d \( -name "modrinth" -o -name "curseforge" \) -print0 | while IFS= read -r -d '' dir; do
    (
        cd "$dir" || exit 1
        packwiz refresh
    )
done