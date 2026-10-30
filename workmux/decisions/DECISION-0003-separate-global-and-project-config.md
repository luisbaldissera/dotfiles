# DECISION-0003: Separate global and project configuration

- Status: Accepted
- Date: 2026-10-30

## Context

workmux supports global personal defaults and project-level overrides with different ownership and portability concerns.

## Decision

Keep only cross-project personal defaults in this component. Store project-specific `.workmux.yaml` files in their respective project repositories.

## Consequences

The dotfiles repository stays reusable across projects, and project workflows travel with the projects that depend on them.

