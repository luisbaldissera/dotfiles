# DECISION-0001: Dedicated Laio component

- Status: Accepted
- Date: 2026-10-31

## Context

Laio introduces its own executable, global configuration directory, session lifecycle, and project-local configuration convention. Folding those responsibilities into tmux would make ownership and deployment ambiguous.

## Decision

Create `laio/` as an independently scoped component with its own source configuration, package definition, sync script, context, decisions, specialist instructions, and custom Codex agent. Keep tmux configuration and Laio configuration in their respective components.

## Consequences

Laio can evolve and deploy independently while still using tmux as its primary backend. Cross-component changes must be coordinated through the root dotfiles agent.
