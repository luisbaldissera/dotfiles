# DECISION-0005: Preserve the Ctrl-w namespace for tmux navigation

- Status: Accepted
- Date: 2026-10-31

## Context

Seamless movement between Neovim splits and tmux panes is required for both
`h/j/k/l` and arrow directions. `vim-tmux-navigator` defaults to bare
`Ctrl-h/j/k/l` mappings, which would displace unrelated Neovim and terminal
key behavior.

## Decision

Load `vim-tmux-navigator` with its default mappings disabled. Map only
`Ctrl-w` followed by `h/j/k/l` or the matching arrow key to the plugin's
directional commands. These commands perform normal Neovim window movement
first and invoke tmux only when Neovim is already at the requested edge.

## Consequences

Neovim's window-command prefix remains the single navigation namespace, the
other `Ctrl-w` commands retain their normal behavior, and bare control keys are
not claimed by this integration. The tmux configuration must pass these
two-key sequences through to Neovim and provide equivalent pane movement when
the active pane is not running Neovim.
