# Arch Linux configuration agents

This repository contains five independently scoped Codex work areas. Each component keeps its managed configuration in `config/`, deployment logic in `sync.sh`, current-state notes in `CONTEXT.md`, and architectural decisions in `decisions/`.

| Component | Repository source | System destination |
| --- | --- | --- |
| tmux | `tmux/config/tmux.conf` | `~/.tmux.conf` |
| Kitty | `kitty/config/kitty.conf` | `${XDG_CONFIG_HOME:-~/.config}/kitty/kitty.conf` |
| Neovim | `neovim/config/` | `${XDG_CONFIG_HOME:-~/.config}/nvim/` |
| workmux | `workmux/config/config.yaml` | `${XDG_CONFIG_HOME:-~/.config}/workmux/config.yaml` |
| Zsh | `zsh/config/zprofile`, `zsh/config/zshrc` | `~/.zprofile`, `~/.zshrc` |

## Use a specialist agent

Start Codex with the component as the working directory so its scoped `AGENTS.md` is loaded:

```bash
cd tmux    # or kitty / neovim / workmux / zsh
codex
```

## Coordinate cross-component changes

Start Codex at the repository root and ask for the `dotfiles` agent when a request affects more than one component:

```text
Use the dotfiles agent to make Kitty, tmux, and Neovim share one coherent
terminal color scheme. Delegate each component to its specialist, wait for all
of them, reconcile the result, and validate everything without deploying it.
```

The project defines custom agents in `.codex/agents/`:

| Agent | Responsibility |
| --- | --- |
| `dotfiles` | Breaks a request into component tasks, coordinates dependencies, and consolidates results |
| `tmux` | Owns changes under `tmux/` |
| `kitty` | Owns changes under `kitty/` |
| `neovim` | Owns changes under `neovim/` |
| `workmux` | Owns changes under `workmux/` |
| `zsh` | Owns changes under `zsh/` |

Independent component tasks may run in parallel. Each specialist edits only its own directory, while the coordinator owns root documentation, aggregate scripts, and agent configuration. Deployment still requires an explicit request.

## Deploy a configuration

Each sync script is one-way: repository to system. Preview first:

```bash
./sync_all.sh --dry-run

# Or preview one component:
./tmux/sync.sh --dry-run
./kitty/sync.sh --dry-run
./neovim/sync.sh --dry-run
./workmux/sync.sh --dry-run
./zsh/sync.sh --dry-run
```

Run `./sync_all.sh` to deploy every component, or run an individual component script. Arguments passed to `sync_all.sh` are forwarded to every component script. Existing managed configuration is backed up below `${XDG_STATE_HOME:-~/.local/state}/config-agents/backups/` whenever a change is detected. Pass `--no-backup` only when a backup is intentionally unnecessary.

Neovim sync mirrors the managed tree and removes stale managed files from the destination. A destination `.git/` directory is excluded from both copying and deletion.

The workmux sync script installs the binary with `cargo install workmux` when it is missing, exposes Cargo's binary through `~/.local/bin/workmux` when `~/.cargo/bin` is not on `PATH`, then deploys the global configuration. Project-specific `.workmux.yaml` files remain in their respective project repositories.

Zsh sync manages only `.zprofile` and `.zshrc`. It deliberately excludes history, completion dumps, installed frameworks and plugins, caches, and `${XDG_CONFIG_HOME:-~/.config}/zsh/secrets.zsh`. Copy `zsh/secrets.example.zsh` to that local secrets path and populate it outside Git when shell-exported credentials are required.
