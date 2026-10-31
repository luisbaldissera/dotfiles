# Neovim context

Last baseline import: 2026-10-30 from the working tree at `~/.config/nvim` on Arch Linux.

## Managed paths

- Repository source: `config/` (the contents of the Neovim config directory)
- System destination: `${XDG_CONFIG_HOME:-$HOME/.config}/nvim/`
- Deployment: `sync.sh`
- Neovim version observed at import: 0.12.6 with LuaJIT 2.1

## Import state

- The source was itself a Git repository on branch `main`, tracking `origin` at `luisbaldissera/nvim-configuration`.
- Nested `.git/` metadata was deliberately excluded from this repository.
- The imported working tree includes the source repository's local state: a modified `lua/plugins/oil.lua`, deletion of `lua/plugins/videre.lua`, and untracked `docs/`, `index.norg`, and `journal/` content.
- Files ignored by the source repository but present in the live configuration were imported because this baseline captures actual behavior. These include `.airules`, `.luarc.json`, `lazy-lock.json`, and available snippet files.

## Current architecture

- `init.lua` defines core options, leaders, basic tab/buffer mappings, loads `config.lazy`, and selects Gruvbox.
- `lua/config/lazy.lua` bootstraps `lazy.nvim`, imports plugin specs from `lua/plugins/`, disables Hererocks, and enables update checking.
- There are 34 plugin specification files covering completion, formatting, Git, DAP, LSP/Mason, navigation, UI, Neorg, Overseer, Tree-sitter management, and related tooling.
- `vim-tmux-navigator` is pinned in `lazy-lock.json` and maps only `Ctrl-w` followed by `h/j/k/l` or an arrow key. It uses native Neovim window movement when a split exists in that direction and hands navigation to tmux only at the editor boundary; the plugin's bare `Ctrl-h/j/k/l` and `Ctrl-\\` defaults are disabled.
- Neovim 0.11-style LSP definitions live under `lsp/`; current named configurations include Copilot, LemMinX, Lua LS, and rust-analyzer.
- Custom behavior is split between Lua modules under `lua/` and legacy Vimscript under `plugin/` plus `config.vim`.
- Personal Neorg material and snippets are stored within the configuration tree and are therefore managed by the repository.
- `plugin/openai.vim` contains only a placeholder key and reads a real key from `OPENAI_API_KEY` at runtime; credentials must remain outside the repository.

## Operational notes

- A first startup in an empty data directory can clone `lazy.nvim` and install plugins, so full startup validation may use the network and mutate XDG data/cache locations.
- Mason-managed tools and plugin installations are runtime dependencies, not repository contents.
- Sync mirrors the repository tree and removes stale managed destination files while preserving a destination `.git/` directory.

