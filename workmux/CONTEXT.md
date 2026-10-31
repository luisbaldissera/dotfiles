# workmux context

Baseline created: 2026-10-30 on Arch Linux.

## Managed paths

- Repository source: `config/config.yaml`
- System destination: `${XDG_CONFIG_HOME:-$HOME/.config}/workmux/config.yaml`
- Deployment and installation: `sync.sh`
- Installation command: `cargo install workmux`
- Cargo binary: `${CARGO_HOME:-$HOME/.cargo}/bin/workmux`
- PATH-compatible symlink: `~/.local/bin/workmux` when required
- Cargo version observed at initialization: 1.98.0
- workmux version installed at initialization: 0.1.277

## Current state

- No existing workmux binary or global configuration was present when this component was initialized. workmux 0.1.277 was then installed with Cargo.
- Arch's system Cargo installed the executable at `~/.cargo/bin/workmux`, while that directory was not on the observed `PATH`; `~/.local/bin` was on `PATH`.
- The managed global configuration uses tmux window mode, Codex as the default agent, and a focused agent pane above a 30% shell. `--agent claude` selects Claude Code through the `<agent>` placeholder.
- Named layouts provide `solo` (selected agent only) and `pair` (Codex and Claude Code side by side in one worktree).
- Native workmux status-format integration is explicitly enabled; no additional status plugin is required.
- tmux is the intended primary terminal multiplexer.
- Project-specific behavior belongs in `.workmux.yaml` within each project and is outside this global dotfiles component.

## Configuration model

- workmux reads personal defaults from `${XDG_CONFIG_HOME:-$HOME/.config}/workmux/config.yaml`.
- It walks upward from the current directory to find the nearest project-level `.workmux.yaml`.
- Project configuration overrides global scalar and layout settings. Hook and file-operation lists can include `"<global>"` when global list values should be retained.
- Cache and runtime state live below `${XDG_CACHE_HOME:-$HOME/.cache}/workmux` and `${XDG_STATE_HOME:-$HOME/.local/state}/workmux`; neither is managed here.

## Operational notes

- `sync.sh` installs workmux only when neither a usable executable nor Cargo-installed binary exists; it does not automatically upgrade an existing installation.
- If the Cargo binary exists but is not on `PATH`, sync creates `~/.local/bin/workmux` as a symlink to it.
- Commands that add, merge, rebase, or remove worktrees change Git and tmux state and require deliberate use.
- `workmux setup --hooks` is a separate interactive deployment step. In 0.1.277 it detects agent configuration directories and installs/updates hooks for all detected agents needing setup after one confirmation; it preserves unrelated settings and enables Codex's hooks feature.
- Agent settings (`CODEX_HOME`/`CLAUDE_CONFIG_DIR`, normally `~/.codex`/`~/.claude`) are not sync targets. Native hook installation has not been deployed by this configuration change.
- There is no backend YAML field in 0.1.277. Inside tmux its environment selects tmux; `WORKMUX_BACKEND=tmux` is available as an explicit override.
- See `README.md` for launch examples, deployment, and native status setup. Configuration compatibility is checked against the installed 0.1.277 binary and Cargo source.
