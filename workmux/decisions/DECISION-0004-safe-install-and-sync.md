# DECISION-0004: Safe installation and one-way sync

- Status: Accepted
- Date: 2026-10-30

## Context

The workmux component manages both an external Cargo executable and a global configuration file.

## Decision

`sync.sh` checks installation, PATH exposure, and configuration state; supports `--dry-run`; installs only when the executable is missing; manages a `~/.local/bin/workmux` symlink when needed; skips identical configuration; and backs up changed destinations before replacement by default.

## Consequences

The component works through `sync_all.sh` without reinstalling workmux on every run. Configuration deployment remains explicit and recoverable.
