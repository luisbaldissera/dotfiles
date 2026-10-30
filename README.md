# Arch Linux configuration agents

This repository contains three independently scoped Codex work areas. Each component keeps its managed configuration in `config/`, deployment logic in `sync.sh`, current-state notes in `CONTEXT.md`, and architectural decisions in `decisions/`.

| Component | Repository source | System destination |
| --- | --- | --- |
| tmux | `tmux/config/tmux.conf` | `~/.tmux.conf` |
| Kitty | `kitty/config/kitty.conf` | `${XDG_CONFIG_HOME:-~/.config}/kitty/kitty.conf` |
| Neovim | `neovim/config/` | `${XDG_CONFIG_HOME:-~/.config}/nvim/` |

## Use a specialist agent

Start Codex with the component as the working directory so its scoped `AGENTS.md` is loaded:

```bash
cd tmux    # or kitty / neovim
codex
```

## Deploy a configuration

Each sync script is one-way: repository to system. Preview first:

```bash
./tmux/sync.sh --dry-run
./kitty/sync.sh --dry-run
./neovim/sync.sh --dry-run
```

Run the same script without `--dry-run` to deploy. Existing managed configuration is backed up below `${XDG_STATE_HOME:-~/.local/state}/config-agents/backups/` whenever a change is detected. Pass `--no-backup` only when a backup is intentionally unnecessary.

Neovim sync mirrors the managed tree and removes stale managed files from the destination. A destination `.git/` directory is excluded from both copying and deletion.

