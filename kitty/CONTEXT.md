# Kitty context

Last baseline import: 2026-10-30. The configuration intentionally starts empty, as requested.

## Managed paths

- Repository source: `config/kitty.conf`
- System destination: `${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty.conf`
- Deployment: `sync.sh`
- Kitty version observed at initialization: 0.49.2

## Current behavior

`config/kitty.conf` is a zero-byte file, so Kitty uses its built-in defaults. No theme, font, key mapping, shell integration, layout, tab-bar, or performance customization has been selected yet.

## Operational notes

- The live `~/.config/kitty/kitty.conf` was also empty when inspected, but the repository baseline is intentionally derived from the user's explicit request rather than from that directory.
- Kitty includes a `kitty.d/` directory in the live configuration tree. It is not managed or imported by this setup.
- Add managed include files only after recording how `sync.sh` should deploy them.

