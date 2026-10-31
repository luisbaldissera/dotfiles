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
pkgbuild="$script_dir/package/PKGBUILD"
package_name=laio-bin
expected_package_version=0.18.0-1
source_file="$script_dir/config/_default.yaml"
config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
target_file="$config_home/laio/_default.yaml"

[[ -f "$pkgbuild" ]] || { printf 'Missing package definition: %s\n' "$pkgbuild" >&2; exit 1; }
[[ -f "$source_file" ]] || { printf 'Missing source: %s\n' "$source_file" >&2; exit 1; }
command -v pacman >/dev/null 2>&1 || { printf 'pacman is required to manage %s\n' "$package_name" >&2; exit 1; }

installed_package_version="$(pacman -Q "$package_name" 2>/dev/null | awk '{print $2}' || true)"
package_required=false
if [[ "$installed_package_version" != "$expected_package_version" ]]; then
  package_required=true
fi

config_required=true
if [[ -f "$target_file" ]] && cmp -s -- "$source_file" "$target_file"; then
  config_required=false
fi

if $dry_run; then
  if $package_required; then
    if [[ -n "$installed_package_version" ]]; then
      printf 'Would replace %s %s with pinned version %s through Pacman\n' \
        "$package_name" "$installed_package_version" "$expected_package_version"
    else
      printf 'Would build %s %s and install it through Pacman\n' \
        "$package_name" "$expected_package_version"
    fi
  else
    printf 'Pacman package is current: %s %s\n' "$package_name" "$installed_package_version"
  fi

  if $config_required; then
    printf 'Would install %s -> %s\n' "$source_file" "$target_file"
  else
    printf 'Already in sync: %s\n' "$target_file"
  fi
  exit 0
fi

if $package_required; then
  command -v makepkg >/dev/null 2>&1 || {
    printf 'makepkg is required to build %s (install the base-devel group)\n' "$package_name" >&2
    exit 1
  }

  build_dir="$(mktemp -d "${TMPDIR:-/tmp}/laio-package.XXXXXXXX")"
  cleanup() {
    chmod -R u+w -- "$build_dir" 2>/dev/null || true
    rm -rf -- "$build_dir"
  }
  trap cleanup EXIT

  cp -- "$pkgbuild" "$build_dir/PKGBUILD"
  (
    cd -- "$build_dir"
    makepkg --syncdeps --install --needed --clean
  )

  installed_package_version="$(pacman -Q "$package_name" 2>/dev/null | awk '{print $2}' || true)"
  if [[ "$installed_package_version" != "$expected_package_version" ]]; then
    printf 'Expected %s %s after installation, found %s\n' \
      "$package_name" "$expected_package_version" "${installed_package_version:-nothing}" >&2
    exit 1
  fi
  printf 'Installed Pacman package: %s %s\n' "$package_name" "$installed_package_version"

  cleanup
  trap - EXIT
fi

if ! $config_required; then
  printf 'Already in sync: %s\n' "$target_file"
  exit 0
fi

if [[ -e "$target_file" || -L "$target_file" ]] && $backup; then
  backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/config-agents/backups/laio"
  backup_file="$backup_root/_default.yaml.$(date -u +%Y%m%dT%H%M%SZ).$$"
  mkdir -p -- "$backup_root"
  cp -a -- "$target_file" "$backup_file"
  printf 'Backed up existing file to %s\n' "$backup_file"
fi

if [[ -L "$target_file" ]]; then
  rm -- "$target_file"
fi
install -D -m 0644 -- "$source_file" "$target_file"
printf 'Installed %s\n' "$target_file"
