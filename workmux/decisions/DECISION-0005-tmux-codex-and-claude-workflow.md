# DECISION-0005: tmux workflow for Codex and Claude Code

- Status: Accepted
- Date: 2026-10-31

## Context

The user wants workmux integrated with tmux, particularly for Codex agents and
Claude Code. Installed workmux 0.1.277 supports both agent commands, named
layouts, and native lifecycle hook installation for both agents.

## Decision

Replace the initial empty defaults from DECISION-0002 with window mode, Codex as
the default agent, and an agent pane above a 30% shell. Use the `<agent>`
placeholder so `--agent claude` switches the default layout without duplication.
Offer `solo` and `pair` layouts for a single full-size agent or both agents in
one worktree. Preserve the agents' existing permission and sandbox behavior.

Keep workmux's native status-format integration enabled. Use its deliberate,
interactive `workmux setup --hooks` for status hooks rather than vendoring
upstream hooks, adding another tmux plugin, or replacing personal agent config.
Agent setup remains a separate live deployment step, never an implicit sync
action. Select tmux through its normal environment detection; this version has
no backend YAML field.

## Consequences

Both agent CLIs must already be installed and authenticated. Native setup merges
hooks into detected agents' existing configuration and enables the Codex hooks
feature. The setup confirmation applies to all detected agents needing hooks.
Hook changes are owned by workmux, while this repository owns only the global
workmux defaults. Independent coding tasks should use separate worktrees; the
pair layout intentionally shares files and sends a supplied prompt to both.
