# DECISION-0002: Manage one canonical Kitty file

- Status: Accepted
- Date: 2026-10-30

## Context

Kitty supports includes and configuration fragments, but no modularization requirement exists yet.

## Decision

Use `config/kitty.conf` as the only managed file until the configuration is complex enough to justify fragments.

## Consequences

The initial setup and sync remain simple. A future move to fragments must update the sync behavior and context documentation.

