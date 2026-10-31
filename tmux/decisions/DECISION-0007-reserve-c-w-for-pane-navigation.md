# DECISION-0007: Reserve C-w for pane navigation

- Status: Accepted
- Date: 2026-10-31

## Context

After moving the tmux prefix to `C-a`, the prefix table still exposed pane
movement through `h`, `j`, `k`, `l`, and tmux's directional arrow defaults.
This duplicated the new `C-w` navigation namespace and made pane movement
available through two unrelated key sequences.

## Decision

Explicitly unbind `h`, `j`, `k`, `l`, and all four arrow keys from tmux's
prefix table. Keep pane navigation exclusively under `C-w` followed by the
matching Vim direction or arrow key.

This supersedes the prefix-table pane-binding clause in DECISION-0006.

## Consequences

`C-a` remains the tmux prefix for non-navigation commands, but `C-a` followed
by a direction never changes panes. Both terminal and Neovim pane navigation
use the single `C-w` directional interface.
