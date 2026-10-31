# DECISION-0012: Remove the worktree dashboard override

- Status: Accepted
- Date: 2026-10-31

## Context

The prefix table assigned lowercase `C-a w` to the workmux worktree dashboard.
The Laio session picker now owns the session-management workflow on uppercase
`C-a S`, and the worktree dashboard no longer needs a dedicated tmux shortcut.

## Decision

Remove the `C-a w` workmux dashboard override, allowing tmux's native
`choose-tree` binding on `w` to take effect again. Keep `C-a a` for the workmux
agent sidebar and `C-a S` for the Laio session picker.

This supersedes the lowercase worktree-dashboard shortcut from DECISION-0008
and the retention of that shortcut in DECISION-0011. It does not change the
workmux CLI or its configuration.

## Consequences

`C-a w` once again opens tmux's native session/window tree instead of workmux.
The worktree dashboard remains available through
`workmux dashboard --tab worktrees` when needed. Laio session switching,
workmux agent access, and `C-w` pane navigation remain separate and unchanged.
