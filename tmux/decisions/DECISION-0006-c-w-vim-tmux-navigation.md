# DECISION-0006: C-w Vim-tmux navigation with a C-a prefix

- Status: Accepted
- Date: 2026-10-31

## Context

The tmux prefix previously occupied `C-w`, preventing Neovim's native `C-w` window commands from remaining the primary interface. Seamless directional navigation is needed for `C-w` followed by `h`, `j`, `k`, `l`, or an arrow key, but the usual bare `C-h`, `C-j`, `C-k`, and `C-l` navigator mappings are not wanted.

## Decision

Move the tmux prefix to `C-a` and keep the existing prefix-table pane bindings under that prefix. Add a tmux-native transient key table for directional `C-w` sequences outside Neovim. When the active pane's current command is `nvim`, pass `C-w` through unchanged so Neovim retains control of its complete `C-w` command family.

Do not load the tmux side of `vim-tmux-navigator`, because its default bare control-key mappings conflict with the requested interaction model. Neovim instead owns boundary detection: its `C-w` directional mappings should use `vim-tmux-navigator` commands to select an internal split when possible and invoke `tmux select-pane` only at an outer edge.

This decision supersedes the `C-w` prefix portion of DECISION-0003 and updates the prefix assumed by DECISION-0005.

## Consequences

The tmux prefix and workmux/TPM prefix commands now begin with `C-a`. In Neovim, non-directional `C-w` commands continue to work normally, while the Neovim configuration must provide boundary-aware mappings for both Vim directions and arrow keys. Outside Neovim, `C-w` begins the directional tmux key table; bare navigator control-key bindings remain absent.
