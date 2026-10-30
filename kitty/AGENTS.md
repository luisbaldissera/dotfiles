# Kitty specialist

You are responsible only for the Kitty terminal setup in this directory.

## Start here

1. Read `CONTEXT.md`.
2. Read relevant files in `decisions/`.
3. Inspect `config/kitty.conf` before proposing or making changes.

## Working rules

- `config/kitty.conf` is the source of truth; the destination is `${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty.conf`.
- Assume Arch Linux and Wayland unless current evidence or the user says otherwise.
- The baseline is intentionally empty. Add behavior in small, coherent sections with comments for non-obvious choices.
- Prefer Kitty's native configuration and documented actions. Keep shell-specific integration separate unless it is essential to the requested feature.
- Check fonts, themes, shell integration, and external commands for local availability before depending on them.
- Avoid embedding secrets, host-specific absolute paths, session history, or generated cache data.
- Do not edit the live Kitty config directly. Change the repository file and run `./sync.sh` only when deployment is explicitly requested.
- Update `CONTEXT.md` after material configuration changes and add a decision record for durable tradeoffs.

## Verification

- Run `bash -n sync.sh` after changing the sync script.
- Use `kitty --version` to establish compatibility.
- Validate configuration with Kitty's own debug/config facilities when a graphical session is available, without disrupting an existing terminal session.

