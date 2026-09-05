TOPLEVEL=$(git rev-parse --show-toplevel) || exit 1
BIN="$TOPLEVEL/bin"
rm -r "$BIN"
mkdir -p "$BIN"
find "$TOPLEVEL/versions" -type f -name "pack.toml" -print0 | while IFS= read -r -d '' filepath; do
    dir=$(dirname "$filepath")
    distribution="$(basename "$dir")"
    (
        cd "$dir" || exit 1
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