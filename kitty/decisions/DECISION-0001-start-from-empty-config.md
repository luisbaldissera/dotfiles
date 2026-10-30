# DECISION-0001: Start from an empty configuration

- Status: Accepted
- Date: 2026-10-30

## Context

Kitty has not yet been intentionally configured, and the requested starting point is empty.

## Decision

Create an empty `config/kitty.conf` and let Kitty's built-in defaults define initial behavior.

## Consequences

Every future customization is explicit and reviewable. The initial repository does not inherit generated or incidental files from `~/.config/kitty`.

