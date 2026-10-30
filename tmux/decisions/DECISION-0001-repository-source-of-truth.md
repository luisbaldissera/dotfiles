# DECISION-0001: Repository source of truth

- Status: Accepted
- Date: 2026-10-30

## Context

The existing tmux configuration lived only at `~/.tmux.conf`, making changes difficult to review and reproduce.

## Decision

Store the managed file as `config/tmux.conf`. Treat it as authoritative and deploy it to `~/.tmux.conf` through `sync.sh`.

## Consequences

Changes become reviewable in Git. Direct edits to `~/.tmux.conf` can drift and must be explicitly imported if they should be retained.

