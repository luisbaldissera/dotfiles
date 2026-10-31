# DECISION-0005: Gruvbox prompt through Oh My Zsh

- Status: Accepted
- Date: 2026-10-30

## Context

The user requested https://github.com/moinferdi/gruvbox-zsh for the Zsh theme.

## Decision

Select its `gruvbox-dark` variant through `ZSH_THEME`, matching the dark Gruvbox tmux choice. Install the upstream theme into Oh My Zsh's custom themes directory as an external dependency.

## Consequences

The prompt uses Gruvbox colors and the upstream Git, SSH hostname, and virtualenv display. Existing plugins and runtime setup remain in place. New machines need the theme installed before deploying the startup files; neither startup nor sync downloads it. The terminal palette is configured separately.
