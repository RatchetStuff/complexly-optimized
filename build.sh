toplevel=$(git rev-parse --show-toplevel)
bin_dir="$toplevel/bin"
rm -r "$bin_dir"
mkdir -p "$bin_dir"
find "$toplevel/versions" -type f -name "pack.toml" -print0 | while IFS= read -r -d '' filepath; do
    dir=$(dirname "$filepath")
    distribution="$(basename "$dir")"
    (
        cd "$dir" || exit 1
        case "$distribution" in
        curseforge)
            packwiz cf export
            mv *.zip "$bin_dir"
            ;;
        modrinth)
            packwiz mr export
            mv *.mrpack "$bin_dir"
            ;;
        *)
            echo "Unknown distribution: $distribution"
            exit 1
            ;;
        esac
    )
done