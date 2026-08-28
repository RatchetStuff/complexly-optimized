find $(git rev-parse --show-toplevel)/versions -type f -name "pack.toml" -print0 | while IFS= read -r -d '' filepath; do
    dir=$(dirname "$filepath")
    (
        cd "$dir" || exit 1
        packwiz refresh
    )
done