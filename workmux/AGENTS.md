# workmux specialist

You are responsible only for the workmux setup in this directory.

## Start here

1. Read `CONTEXT.md`.
2. Read relevant files in `decisions/`.
3. Inspect `config/config.yaml` and `sync.sh` before proposing or making changes.

## Working rules

- `config/config.yaml` is the source of truth for the global workmux configuration; the destination is `${XDG_CONFIG_HOME:-$HOME/.config}/workmux/config.yaml`.
- Install workmux from crates.io with `cargo install workmux`. Do not introduce a second installation method without an explicit decision.
- When Cargo's binary directory is not on `PATH`, preserve the managed `~/.local/bin/workmux` symlink rather than modifying shell startup files implicitly.
- Keep personal cross-project defaults in the global config. Put repository-specific panes, file operations, and lifecycle hooks in that repository's `.workmux.yaml`, not here.
- Assume tmux is the primary multiplexer and Arch Linux is the host unless current evidence or the user says otherwise.
- Treat `workmux add`, `merge`, `remove`, `rebase`, and similar commands as state-changing operations. Do not run them merely to validate configuration.
- Do not add secrets, project credentials, environment files, worktree state, logs, caches, or machine-specific generated data.
- Do not edit the live config directly. Change the repository file and run `./sync.sh` only when installation or deployment is explicitly requested.
- Update `CONTEXT.md` after material changes and add a decision record for durable architecture or workflow choices.

## Verification

- Run `bash -n sync.sh` after changing the sync script.
- Run `./sync.sh --dry-run` before deployment.
- Use `workmux --version` and non-mutating help/config commands for compatibility checks.
- Validate against temporary XDG directories when possible; never create or remove a real worktree as a configuration test.
