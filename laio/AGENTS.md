# Laio specialist

You are responsible only for the Laio setup in this directory.

## Start here

1. Read `CONTEXT.md`.
2. Read all relevant files in `decisions/`.
3. Inspect `config/_default.yaml`, `package/PKGBUILD`, and `sync.sh` before proposing or making changes.

## Working rules

- `config/_default.yaml` is the source of truth for the global Laio creation template. Its destination is `${XDG_CONFIG_HOME:-$HOME/.config}/laio/_default.yaml`.
- Keep named global session files and project-local `.laio.yaml` files outside this component unless the user explicitly asks to manage one.
- Install Laio as an Arch package through `package/PKGBUILD` and Pacman. Keep the upstream version and release checksums pinned and update them together.
- Use upstream release archives from `ck3mp3r/laio-cli`; do not add a second installation method without an explicit decision.
- Assume Laio uses tmux as its primary muxer. Do not add Zellij or herdr defaults unless requested.
- Treat `laio start`, `laio stop`, configuration deletion/linking, and session export to a file as state-changing operations. Do not run them merely to validate configuration.
- Do not manage Laio session state, tmux sockets, logs, caches, downloaded archives, built packages, or project-local configuration from this directory.
- Do not edit the live configuration directly. Change the repository files and run `./sync.sh` only when installation or deployment is explicitly requested.
- Update `CONTEXT.md` after material changes and add a sequential decision record for durable architecture or workflow choices.

## Verification

- Run `bash -n sync.sh` after changing the sync script.
- Run `makepkg --printsrcinfo` from `package/` after changing `PKGBUILD`.
- Run `./sync.sh --dry-run` before deployment.
- Validate `config/_default.yaml` with the pinned Laio version by creating (`EDITOR=true`) and validating a named configuration in a temporary config directory.
- Never start or stop a real tmux session during validation.
