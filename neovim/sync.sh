#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s [--dry-run] [--no-backup]\n' "${0##*/}"
}

dry_run=false
backup=true
while (($#)); do
  case "$1" in
    --dry-run) dry_run=true ;;
    --no-backup) backup=false ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'Unknown option: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

command -v rsync >/dev/null 2>&1 || { printf 'rsync is required\n' >&2; exit 1; }

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
source_dir="$script_dir/config/"
config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
target_dir="$config_home/nvim/"

[[ -d "$source_dir" ]] || { printf 'Missing source: %s\n' "$source_dir" >&2; exit 1; }

if [[ -d "$target_dir" ]]; then
  changes="$(rsync -ain --delete --exclude='.git/' -- "$source_dir" "$target_dir")"
else
  changes="Destination directory does not exist."
fi
if [[ -z "$changes" ]]; then
  printf 'Already in sync: %s\n' "$target_dir"
  exit 0
fi

if $dry_run; then
  printf 'Would synchronize %s -> %s\n' "$source_dir" "$target_dir"
  printf '%s\n' "$changes"
  exit 0
fi

if [[ -d "$target_dir" ]] && $backup; then
  backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/config-agents/backups/neovim"
  backup_dir="$backup_root/nvim.$(date -u +%Y%m%dT%H%M%SZ).$$"
  mkdir -p -- "$backup_dir"
  rsync -a -- "$target_dir" "$backup_dir/"
  printf 'Backed up existing directory to %s\n' "$backup_dir"
fi

mkdir -p -- "$target_dir"
rsync -a --delete --exclude='.git/' -- "$source_dir" "$target_dir"
printf 'Synchronized %s\n' "$target_dir"
