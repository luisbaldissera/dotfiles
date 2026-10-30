# DECISION-0003: Safe one-way sync

- Status: Accepted
- Date: 2026-10-30

## Context

Even an empty source file can overwrite a meaningful live configuration later.

## Decision

`sync.sh` deploys only from the repository to the system, supports `--dry-run`, skips identical files, and backs up a changed destination by default.

## Consequences

Deployment remains explicit and recoverable as the Kitty configuration grows.

