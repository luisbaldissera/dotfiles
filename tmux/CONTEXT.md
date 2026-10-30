# tmux context

Last baseline import: 2026-10-30 from `~/.tmux.conf` on Arch Linux.

## Managed paths

- Repository source: `config/tmux.conf`
- System destination: `~/.tmux.conf`
- Deployment: `sync.sh`
- tmux version observed at import: 3.8

## Current behavior

- Prefix is remapped from `C-b` to `C-w`; `C-w C-w` sends the prefix through.
- `h`, `j`, `k`, and `l` select adjacent panes.
- `v` creates a horizontal split and `s` creates a vertical split, both rooted in the active pane's current directory.
- Copy mode uses vi keys and starts with `C-u`.
- Visual selection, `y`, and mouse drag completion pipe copied text to Wayland through `wl-copy`.
- TPM declares `tmux-plugins/tpm` and `tmux-plugins/tmux-sensible` and initializes TPM at the end of the file.

## Operational notes

- Clipboard integration requires `wl-copy`, normally provided by Arch's `wl-clipboard` package.
- Plugin installation and updates are managed by TPM, not by `sync.sh`.
- The repository contains configuration only; runtime state, sockets, logs, and plugins stay outside it.

