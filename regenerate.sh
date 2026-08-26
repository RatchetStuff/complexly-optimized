#!/bin/bash
find versions -type f -name "pack.toml" | while read -r filepath; do
    sed -i -E 's/^version\s*=\s*".*"/version = ""/' "$filepath"
done