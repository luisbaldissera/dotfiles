# System Configuration Repository

This repository manages personal configuration for tmux, Kitty, Neovim, workmux, and Zsh on Arch Linux.

## Repository rules

- Treat the files under each component's `config/` directory as the source of truth.
- Each component has scoped instructions in its own `AGENTS.md` and a matching custom agent in `.codex/agents/`. Start Codex from that component directory for direct specialist work, or use the root dotfiles coordinator for routed work.
- Before changing a component, read its `CONTEXT.md` and all relevant records in `decisions/`.
- Keep `CONTEXT.md` factual and current. Record durable, non-obvious choices in a new sequential `DECISION-XXXX-description.md`; do not rewrite prior accepted decisions just to hide history.
- Never commit credentials, tokens, private keys, machine-specific caches, plugin downloads, or nested Git metadata.
- Sync is repository-to-system only. Do not import live system changes unless the user explicitly requests a refresh.
- Do not run a component's `sync.sh` unless the user explicitly asks to deploy the repository configuration to the system. A dry run is always safe and preferred first.
- Preserve unrelated user changes and validate changes with the narrowest non-destructive checks available.

## Dotfiles coordinator

The root agent is the dotfiles coordinator. When the user asks for the `dotfiles` agent, requests delegation, or describes a change spanning two or more components, use the project-scoped custom agents in `.codex/agents/`.

### Routing

| Concern | Agent | Owned directory |
| --- | --- | --- |
| tmux behavior, bindings, plugins, clipboard, pane/session behavior | `tmux` | `tmux/` |
| Kitty terminal appearance, fonts, mappings, layouts, shell integration | `kitty` | `kitty/` |
| Neovim options, mappings, plugins, LSP, formatting, debugging | `neovim` | `neovim/` |
| workmux installation, global defaults, worktrees, pane orchestration | `workmux` | `workmux/` |
| Zsh startup, PATH and environment, aliases, functions, completion, prompts | `zsh` | `zsh/` |

The `dotfiles` custom agent coordinates requests that cross these boundaries.

### Delegation workflow

1. Classify the request by affected component before editing.
2. Spawn one matching specialist agent per affected component with a concrete, bounded task and explicit success criteria.
3. Run specialists in parallel only when their changes are independent. Sequence dependent work and pass decisions or interfaces from the first specialist to the next.
4. Give each specialist exclusive write ownership of its component directory. Specialists must not edit root files or another component; they report cross-component needs to the coordinator.
5. The coordinator owns `AGENTS.md`, `README.md`, `sync_all.sh`, and `.codex/`. Do not edit a component concurrently while its specialist owns it.
6. Wait for all specialists, inspect the combined diff, reconcile duplicated or conflicting assumptions, and request focused follow-up work when necessary.
7. Run each affected component's validation plus `./sync_all.sh --dry-run` for aggregate verification.
8. Do not deploy live configuration unless the user explicitly requests deployment. Delegation does not broaden that permission.
9. Return one consolidated result describing changes, decisions, validation, and any unresolved cross-component tradeoffs.

For a single-component request, prefer the matching specialist when the user asks for an agent or delegation; otherwise direct scoped work remains acceptable.

## Layout

- `tmux/`: tmux configuration and specialist instructions.
- `kitty/`: Kitty configuration and specialist instructions.
- `neovim/`: Neovim configuration and specialist instructions.
- `workmux/`: workmux installation, global configuration, and specialist instructions.
- `zsh/`: Zsh startup configuration and specialist instructions.
- `.codex/`: project-level Codex settings and custom agent definitions.
