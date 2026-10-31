# workmux with tmux, Codex, and Claude Code

The global config targets workmux 0.1.277. Each worktree opens a tmux window
with Codex above a shell (70/30). Agent commands retain their normal permission
and sandbox settings. Project `.workmux.yaml` files can override these defaults.

From a Git repository inside tmux:

```bash
workmux add feature/search -p "Implement search"
workmux add fix/login --agent claude -p "Fix the login redirect"
workmux add refactor/parser --layout solo --agent codex
workmux add review/api --layout pair
```

`solo` opens only the selected agent. `pair` opens Codex and Claude Code side by
side in the same worktree; a supplied prompt goes to both agents. Use separate
worktrees when assigning independent implementation tasks.

tmux is detected automatically inside tmux. There is no backend YAML option in
this version; outside tmux, use `WORKMUX_BACKEND=tmux workmux …` to select it
explicitly. `mode: window` keeps worktrees in the current tmux session.

## Deploy and enable agent status

Deployment is a deliberate step from the dotfiles repository:

```bash
./workmux/sync.sh --dry-run
./workmux/sync.sh
./tmux/sync.sh --dry-run
./tmux/sync.sh
```

After deploying and reloading tmux, run this once in an interactive terminal:

```bash
workmux setup --hooks
```

Check that the detected-agent list includes **Claude Code** and **Codex** before
accepting the install prompt. Version 0.1.277 detects them by their configuration
directories, so launch each CLI once if its directory does not exist yet.
The single confirmation installs or updates hooks for **all detected agents**
needing setup; it does not offer per-agent selection.

The built-in installer merges hooks into Claude's `settings.json` and Codex's
`hooks.json`, preserving unrelated settings and hooks. For Codex it also enables
`[features] hooks = true` in `config.toml`. It respects `CLAUDE_CONFIG_DIR` and
`CODEX_HOME` (with `CODEX_CONFIG_DIR` as a legacy fallback). These personal files
are outside this repository's sync targets; back them up before running setup.
Restart existing agent sessions after setup. This repository does not run agent
setup during sync or install another status plugin.

Workmux adds working (🤖), waiting (💬), and done (✅) markers to tmux window
formats and registers agents for its dashboard. Codex registers when its first
turn begins; permission requests report the waiting state. Subagent completion
keeps the parent marked working until the parent finishes.

```bash
workmux dashboard
workmux sidebar
workmux last-done
workmux list
```

`sidebar` toggles a live agent sidebar. `last-done` cycles through completed or
waiting agents. Worktree creation, merging, and removal are deliberate actions;
the validation used for these dotfiles does not run them.

Upstream references: [configuration](https://workmux.dev/guide/configuration/),
[agent status tracking](https://workmux.dev/guide/status-tracking/).
