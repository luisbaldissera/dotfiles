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

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
managed_files=(zprofile zshrc)
backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/config-agents/backups/zsh"
timestamp="$(date -u +%Y%m%dT%H%M%SZ)"

for managed_file in "${managed_files[@]}"; do
  source_file="$script_dir/config/$managed_file"
  target_file="$HOME/.$managed_file"

  [[ -f "$source_file" ]] || { printf 'Missing source: %s\n' "$source_file" >&2; exit 1; }

  if [[ -f "$target_file" ]] && cmp -s -- "$source_file" "$target_file"; then
    printf 'Already in sync: %s\n' "$target_file"
    continue
  fi

  if $dry_run; then
    printf 'Would install %s -> %s\n' "$source_file" "$target_file"
    continue
  fi

  if [[ -e "$target_file" ]] && $backup; then
    backup_file="$backup_root/$managed_file.$timestamp.$$"
    mkdir -p -- "$backup_root"
    cp -a -- "$target_file" "$backup_file"
    printf 'Backed up existing file to %s\n' "$backup_file"
  fi

  install -D -m 0644 -- "$source_file" "$target_file"
  printf 'Installed %s\n' "$target_file"
done

