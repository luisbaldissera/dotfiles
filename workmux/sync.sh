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
source_file="$script_dir/config/config.yaml"
config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
target_file="$config_home/workmux/config.yaml"
cargo_home="${CARGO_HOME:-$HOME/.cargo}"
cargo_binary="$cargo_home/bin/workmux"
path_link="$HOME/.local/bin/workmux"

[[ -f "$source_file" ]] || { printf 'Missing source: %s\n' "$source_file" >&2; exit 1; }

install_required=false
installed_binary="$(command -v workmux 2>/dev/null || true)"
if [[ -z "$installed_binary" && ! -x "$cargo_binary" ]]; then
  install_required=true
fi

link_required=false
if [[ -z "$installed_binary" && -x "$cargo_binary" ]]; then
  link_required=true
fi
if $install_required && [[ ":$PATH:" != *":$cargo_home/bin:"* ]]; then
  link_required=true
fi

config_required=true
if [[ -f "$target_file" ]] && cmp -s -- "$source_file" "$target_file"; then
  config_required=false
fi

if $dry_run; then
  if $install_required; then
    printf 'Would install workmux with: cargo install workmux\n'
  elif [[ -n "$installed_binary" ]]; then
    printf 'Already installed: %s\n' "$installed_binary"
  else
    printf 'Cargo binary installed: %s\n' "$cargo_binary"
  fi

  if $link_required; then
    printf 'Would link %s -> %s\n' "$path_link" "$cargo_binary"
  fi

  if $config_required; then
    printf 'Would install %s -> %s\n' "$source_file" "$target_file"
  else
    printf 'Already in sync: %s\n' "$target_file"
  fi
  exit 0
fi

if $install_required; then
  command -v cargo >/dev/null 2>&1 || { printf 'cargo is required to install workmux\n' >&2; exit 1; }
  cargo install workmux
  [[ -x "$cargo_binary" ]] || { printf 'Cargo did not install %s\n' "$cargo_binary" >&2; exit 1; }
  installed_binary="$(command -v workmux 2>/dev/null || true)"
  if [[ -z "$installed_binary" ]]; then
    link_required=true
  fi
fi

if $link_required; then
  if [[ -e "$path_link" || -L "$path_link" ]]; then
    if $backup; then
      backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/config-agents/backups/workmux"
      backup_link="$backup_root/workmux-bin.$(date -u +%Y%m%dT%H%M%SZ).$$"
      mkdir -p -- "$backup_root"
      mv -- "$path_link" "$backup_link"
      printf 'Backed up existing PATH entry to %s\n' "$backup_link"
    else
      rm -f -- "$path_link"
    fi
  fi
  mkdir -p -- "$(dirname -- "$path_link")"
  ln -s -- "$cargo_binary" "$path_link"
  printf 'Linked %s -> %s\n' "$path_link" "$cargo_binary"
  installed_binary="$(command -v workmux 2>/dev/null || true)"
  [[ -n "$installed_binary" ]] || {
    printf 'workmux is installed at %s, but neither it nor %s is on PATH\n' "$cargo_binary" "$(dirname -- "$path_link")" >&2
    exit 1
  }
fi

if ! $config_required; then
  printf 'Already in sync: %s\n' "$target_file"
  exit 0
fi

if [[ -e "$target_file" ]] && $backup; then
  backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/config-agents/backups/workmux"
  backup_file="$backup_root/config.yaml.$(date -u +%Y%m%dT%H%M%SZ).$$"
  mkdir -p -- "$backup_root"
  cp -a -- "$target_file" "$backup_file"
  printf 'Backed up existing file to %s\n' "$backup_file"
fi

install -D -m 0644 -- "$source_file" "$target_file"
printf 'Installed %s\n' "$target_file"
