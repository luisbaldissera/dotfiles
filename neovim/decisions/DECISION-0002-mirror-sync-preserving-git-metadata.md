# DECISION-0002: Mirror sync while preserving destination Git metadata

- Status: Accepted
- Date: 2026-10-30

## Context

Neovim loads files recursively from its configuration directory, so stale files left after a rename or deletion can continue to affect behavior. The current live destination also contains useful nested Git metadata.

## Decision

Use `rsync --delete` for repository-to-system deployment while excluding `.git/` from copying and deletion. Preview changes with `--dry-run` and back up the destination by default before applying a detected change.

## Consequences

Managed files exactly mirror the repository after sync, and stale managed files are removed. Destination Git metadata survives. The script must be treated as a deployment operation because deletions are possible.

