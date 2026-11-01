#!/usr/bin/env bash
set -euo pipefail
export TZ='UTC'

# Find previous tag
previous_tag=$(git tag --sort=-version:refname | head -n 1)
if [[ -z "$previous_tag" ]]; then
  echo "No previous tag found" >&2
  exit 1
fi

# Create version
release_version_year=$(date -u +'%y')
release_version_month=$(date -u +'%m')
release_version_patch=$(git tag -l "${release_version_year}.${release_version_month}.*" | wc -l)
release_version="${release_version_year}.${release_version_month}.${release_version_patch}"

# Bump pack version
REPOSITORY=$(git rev-parse --show-toplevel)
find "$REPOSITORY/versions" -type f -name 'pack.toml' -print0 | while IFS= read -r -d '' filepath; do
  dir=$(dirname "$filepath")
  if [[ -n "$previous_tag" ]] && git diff --quiet "$previous_tag" -- "$dir"; then
    continue
  fi

  IFS='/' read -ra parts <<< "${filepath#"$REPOSITORY/versions/"}"
  loader="${parts[0]}"
  mc_version="${parts[1]}"

  full_version="${release_version}+mc${mc_version}.${loader}"
  sed -i -E "s/^version = .*/version = \"${full_version}\"/" "$filepath"
done

echo "$release_version"