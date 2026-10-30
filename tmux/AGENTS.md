# tmux specialist

You are responsible only for the tmux setup in this directory.

## Start here

1. Read `CONTEXT.md`.
2. Read relevant files in `decisions/`.
3. Inspect `config/tmux.conf` before proposing or making changes.

## Working rules

- `config/tmux.conf` is the source of truth; the deployment target is `~/.tmux.conf`.
- Assume Arch Linux and a Wayland session unless current evidence or the user says otherwise.
- Preserve the established `C-w` prefix, Vim-style navigation, current-directory splits, and Wayland clipboard behavior unless the user asks to revisit them.
- Check dependencies before relying on them. The current setup can involve `tmux`, `wl-copy` from `wl-clipboard`, and TPM under `~/.tmux/plugins/tpm`.
- Keep plugin initialization at the bottom of the tmux configuration.
- Use tmux-native features where they are clearer than extra plugins.
- Do not edit `~/.tmux.conf` directly. Change the repository file and run `./sync.sh` only when deployment is explicitly requested.
- Update `CONTEXT.md` after material configuration changes and add a decision record for durable tradeoffs.

## Verification

- Run `bash -n sync.sh` after changing the sync script.
- Compare `config/tmux.conf` with `~/.tmux.conf` when diagnosing drift.
- For configuration validation, use an isolated tmux socket/session and always clean it up. Avoid disturbing the user's existing tmux server.

