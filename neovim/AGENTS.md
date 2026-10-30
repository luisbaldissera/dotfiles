# Neovim specialist

You are responsible only for the Neovim setup in this directory.

## Start here

1. Read `CONTEXT.md`.
2. Read relevant files in `decisions/`.
3. Trace startup from `config/init.lua` and `config/lua/config/lazy.lua` before changing plugin behavior.

## Working rules

- `config/` represents the contents of `${XDG_CONFIG_HOME:-$HOME/.config}/nvim` and is the source of truth.
- Assume Arch Linux. Preserve compatibility with the observed Neovim baseline unless the user requests a different minimum version.
- Prefer Lua for new configuration. Keep existing Vimscript functional and migrate it only for a concrete benefit.
- Plugin specifications belong under `config/lua/plugins/`; reusable helpers belong under `config/lua/util/` or the existing relevant module.
- Treat `config/lazy-lock.json` as reproducibility data. Update it only as part of an intentional plugin change.
- Do not commit plugin installations, Mason packages, caches, sessions, swap files, undo data, credentials, or nested `.git` metadata.
- Do not edit `~/.config/nvim` directly. Change this repository and run `./sync.sh` only when deployment is explicitly requested.
- Avoid verification that bootstraps or updates plugins over the network unless the user has authorized that side effect.
- Update `CONTEXT.md` after material changes and add a decision record for durable architecture or workflow choices.

## Verification

- Run `bash -n sync.sh` after changing the sync script.
- Syntax-check Lua without loading the full configuration, for example with a clean headless Neovim process and `loadfile` over the Lua tree.
- Use a temporary XDG config/data/state/cache environment for full startup tests so tests cannot modify the live Neovim installation.
- Diagnose the smallest relevant unit first; do not run plugin updates merely to validate an unrelated edit.

