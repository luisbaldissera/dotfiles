# DECISION-0009: Remove the tmux Gruvbox theme

- Status: Accepted
- Date: 2026-10-31

## Context

The tmux configuration should no longer install or configure a Gruvbox theme.

## Decision

Remove the `egel/tmux-gruvbox` TPM declaration and its palette setting. Keep the existing TPM and tmux-sensible declarations without adding another tmux theme.

This supersedes DECISION-0004.

## Consequences

tmux uses its unthemed/default appearance unless another source configures it at runtime. TPM no longer installs or updates tmux-gruvbox for this repository configuration.
