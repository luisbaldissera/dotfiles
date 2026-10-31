# DECISION-0004: Gruvbox theme through TPM

- Status: Accepted
- Date: 2026-10-30

## Context

The user requested the theme from https://github.com/egel/tmux-gruvbox.

## Decision

Declare `egel/tmux-gruvbox` through the existing TPM setup and explicitly select its `dark` palette. Keep theme settings before TPM initialization.

## Consequences

TPM manages the theme installation alongside existing plugins. After deployment, `C-w I` installs the plugin. Plugin downloads remain outside the repository.
