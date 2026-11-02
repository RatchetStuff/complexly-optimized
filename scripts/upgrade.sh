#!/usr/bin/env bash
set -euo pipefail

# Arguments (uses eza as format)
while [[ $# -gt 0 ]]; do
  HELP_USAGE="\033[1;4mUsage:\033[0m \033[1m$0\033[0m [OPTIONS]"
  case "$1" in
    '-?'|--help)
      echo -e "Upgrade modpacks

$HELP_USAGE

\033[1;4mOPTIONS:\033[0m
  \033[1m-?, --help\033[0m  print help"
      exit 0
      ;;
    *)
      echo -e "\033[1;31merror:\033[0m unexpected argument '\033[33m$1\033[0m' found

$HELP_USAGE

For more information, try '\033[1m--help\033[0m'."
      exit 1
      ;;
  esac
done

REPOSITORY=$(git rev-parse --show-toplevel)
"$REPOSITORY"/scripts/upgrade/loaders.sh
"$REPOSITORY"/scripts/upgrade/mods.sh