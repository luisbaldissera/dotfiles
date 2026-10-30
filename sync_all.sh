#!/usr/bin/env bash
set -uo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

mapfile -d '' -t sync_scripts < <(
  find "$script_dir" -mindepth 2 -maxdepth 2 -type f -name sync.sh -print0 |
    sort -z
)

if ((${#sync_scripts[@]} == 0)); then
  printf 'No component sync scripts found under %s\n' "$script_dir" >&2
  exit 1
fi

overall_status=0
for sync_script in "${sync_scripts[@]}"; do
  component_dir="${sync_script%/sync.sh}"
  component_name="${component_dir#"$script_dir"/}"

  printf '\n==> Syncing %s\n' "$component_name"
  if [[ ! -x "$sync_script" ]]; then
    printf 'Sync script is not executable: %s\n' "$sync_script" >&2
    overall_status=1
    continue
  fi

  if ! "$sync_script" "$@"; then
    printf 'Sync failed for %s\n' "$component_name" >&2
    overall_status=1
  fi
done

if ((overall_status != 0)); then
  printf '\nOne or more components failed to sync.\n' >&2
  exit "$overall_status"
fi

printf '\nAll components synced successfully.\n'
