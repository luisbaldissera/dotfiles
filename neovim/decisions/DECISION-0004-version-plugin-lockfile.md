# DECISION-0004: Version the plugin lockfile in this repository

- Status: Accepted
- Date: 2026-10-30

## Context

The source repository ignored `lazy-lock.json`, but the file exists in the live configuration and determines resolved plugin revisions.

## Decision

Keep `config/lazy-lock.json` in this repository as part of the captured, reproducible baseline.

## Consequences

Plugin revision changes become reviewable. Agents should avoid incidental lockfile churn and update it only during intentional plugin maintenance.

