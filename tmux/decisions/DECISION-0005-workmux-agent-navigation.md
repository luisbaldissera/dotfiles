# DECISION-0005: Workmux agent navigation with native tmux popups

- Status: Accepted
- Date: 2026-10-31

## Context

The workmux workflow needs convenient access to Codex and Claude Code agents while preserving the existing `C-w` prefix, Vim navigation, and Gruvbox theme. Installed workmux 0.1.277 provides a dashboard, worktrees tab, completion/input navigation, and automatic tmux status formatting.

## Decision

Use `C-w a` for an agent dashboard popup, `C-w W` for its worktrees tab, and `C-w L` for `workmux last-done`. Popups use the active pane's working directory and occupy 90% of the terminal. Preserve lowercase `l` for pane navigation and `C-w C-w` for sending the prefix.

Let workmux augment the existing per-window status formats instead of replacing Gruvbox's global status formats or adding another plugin. Keep workmux automatic status formatting enabled. Agent-specific hooks and defaults belong to the workmux component.

## Consequences

The bindings work with either supported agent and require workmux on tmux's `PATH`. Agent hooks must be installed before tracked agents and their statuses appear. Existing tmux navigation, clipboard behavior, and TPM initialization stay intact. The dashboard's worktree actions can modify Git state and should be used deliberately.
