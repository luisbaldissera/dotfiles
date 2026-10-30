# System Configuration Repository

This repository manages personal configuration for tmux, Kitty, and Neovim on Arch Linux.

## Repository rules

- Treat the files under each component's `config/` directory as the source of truth.
- Each component has scoped instructions in its own `AGENTS.md`. Start Codex from that component directory when you want its specialist behavior.
- Before changing a component, read its `CONTEXT.md` and all relevant records in `decisions/`.
- Keep `CONTEXT.md` factual and current. Record durable, non-obvious choices in a new sequential `DECISION-XXXX-description.md`; do not rewrite prior accepted decisions just to hide history.
- Never commit credentials, tokens, private keys, machine-specific caches, plugin downloads, or nested Git metadata.
- Sync is repository-to-system only. Do not import live system changes unless the user explicitly requests a refresh.
- Do not run a component's `sync.sh` unless the user explicitly asks to deploy the repository configuration to the system. A dry run is always safe and preferred first.
- Preserve unrelated user changes and validate changes with the narrowest non-destructive checks available.

## Layout

- `tmux/`: tmux configuration and specialist instructions.
- `kitty/`: Kitty configuration and specialist instructions.
- `neovim/`: Neovim configuration and specialist instructions.

