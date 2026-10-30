# DECISION-0002: Start with built-in defaults

- Status: Accepted
- Date: 2026-10-30

## Context

There was no existing workmux configuration to import, and workmux can operate without customized global settings.

## Decision

Manage a valid empty mapping in `config/config.yaml` and add personal defaults only when a concrete preference is established.

## Consequences

Initial behavior tracks workmux defaults, while future customizations remain explicit and reviewable.

