# tmux context

Last baseline import: 2026-10-30 from `~/.tmux.conf` on Arch Linux.

## Managed paths

- Repository source: `config/tmux.conf`
- System destination: `~/.tmux.conf`
- Deployment: `sync.sh`
- tmux version observed at import: 3.8

## Current behavior

- Prefix is remapped from `C-b` to `C-a`; `C-a C-a` sends the prefix through.
- The prefix table explicitly unbinds `h`, `j`, `k`, `l`, and all four arrow keys, so `C-a` directional sequences never select panes.
- `C-w` followed by `h`, `j`, `k`, `l`, or an arrow key selects an adjacent tmux pane outside Neovim. In Neovim panes, tmux passes `C-w` through so Neovim retains its native window-command priority and can hand boundary navigation back to tmux through `vim-tmux-navigator`. No bare `C-h`, `C-j`, `C-k`, or `C-l` tmux mappings are installed.
- `v` creates a horizontal split and `s` creates a vertical split, both rooted in the active pane's current directory.
- Copy mode uses vi keys and starts with `C-u`.
- Visual selection, `y`, and mouse drag completion pipe copied text to Wayland through `wl-copy`.
- `C-a a` focuses the workmux agent sidebar in the current window, starting the sidebar first when needed.
- `C-a w` uses tmux's native session/window tree; there are no `C-a w`, `C-a W`, or `C-a L` workmux bindings. Pane navigation remains exclusively under `C-w`.
- Laio is the session-management interface. `C-a S` opens Laio's 50-column by 16-row configuration picker, which lists active and available Laio sessions and can start or switch to the selection. The binding is global, so it is also available from ordinary tmux sessions.
- Sessions started by Laio additionally inject upstream's `prefix M-l` binding at runtime, which resolves to `C-a M-l` and opens the same picker.
- TPM declares only `tmux-plugins/tpm` and `tmux-plugins/tmux-sensible` and initializes TPM at the end of the file. tmux does not manage a color theme.

## Operational notes

- Clipboard integration requires `wl-copy`, normally provided by Arch's `wl-clipboard` package.
- Plugin installation and updates are managed by TPM, not by `sync.sh`.
- The workmux bindings require `workmux` on tmux's `PATH`. Agent registration requires the Codex/Claude Code hooks installed separately through workmux setup; see `../workmux/` for the managed workflow.
- Laio installation and session definitions are managed outside this component. `C-a S` requires `laio` on tmux's `PATH`; ordinary tmux sessions receive this repository binding but do not receive Laio's runtime-only `C-a M-l` alias.
- The workmux worktree dashboard remains available from the `workmux dashboard --tab worktrees` CLI command but has no tmux shortcut.
- The repository contains configuration only; runtime state, sockets, logs, and plugins stay outside it.
