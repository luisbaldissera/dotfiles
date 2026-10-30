# DECISION-0002: Safe one-way sync

- Status: Accepted
- Date: 2026-10-30

## Context

Deployment overwrites a file in the user's home directory and must make its direction and effects unambiguous.

## Decision

`sync.sh` deploys only from the repository to the system, supports `--dry-run`, skips identical files, and creates a timestamped backup by default before replacement.

## Consequences

Deployment is predictable and recoverable. Importing system-side edits is a separate, explicit operation.

