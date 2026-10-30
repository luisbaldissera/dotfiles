# DECISION-0002: Safe one-way multi-file sync

- Status: Accepted
- Date: 2026-10-30

## Context

Deployment replaces multiple startup files in the user's home directory and must make its direction and effects unambiguous without deleting unrelated shell state.

## Decision

`sync.sh` deploys only `zprofile` and `zshrc` from the repository to the system, supports `--dry-run`, skips identical files, and creates a timestamped backup for each changed destination by default.

## Consequences

Deployment is predictable and recoverable. History, generated completion data, installed frameworks, caches, and other startup files are neither copied nor deleted.

