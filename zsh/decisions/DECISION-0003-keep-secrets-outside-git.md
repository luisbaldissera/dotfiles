# DECISION-0003: Keep secrets outside Git

- Status: Accepted
- Date: 2026-10-30

## Context

The imported `.zshrc` contained plaintext API credentials. Committing those values would expose them through Git history and every repository clone.

## Decision

Exclude all credential values from the managed configuration. Source an optional local `${XDG_CONFIG_HOME:-$HOME/.config}/zsh/secrets.zsh` file and provide only a value-free example in the repository.

## Consequences

Each machine must provision its own protected secrets file or provide credentials through another mechanism. Previously exposed credentials must be revoked and replaced. `sync.sh` never reads, writes, or backs up the secrets file.

