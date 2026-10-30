# DECISION-0001: Repository source of truth

- Status: Accepted
- Date: 2026-10-30

## Context

The existing Zsh configuration lived only in `~/.zprofile` and `~/.zshrc`, making changes difficult to review and reproduce.

## Decision

Store the managed startup files as `config/zprofile` and `config/zshrc`. Treat them as authoritative and deploy them to their dot-prefixed home-directory paths through `sync.sh`.

## Consequences

Changes become reviewable in Git. Direct edits to the live files can drift and must be explicitly imported if they should be retained. Startup files that were absent at baseline remain unmanaged.

