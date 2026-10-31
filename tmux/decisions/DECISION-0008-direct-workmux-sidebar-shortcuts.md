# DECISION-0008: Direct workmux sidebar shortcuts

- Status: Accepted
- Date: 2026-10-31

## Context

The workmux dashboard popup adds an intermediate screen when the immediate goal is to use the persistent agent sidebar. The uppercase worktrees binding and the last-done binding are also no longer wanted. Installed workmux 0.1.277 has an agent sidebar but does not expose a persistent worktrees sidebar view.

## Decision

Use `C-a a` to focus the workmux sidebar pane in the current window, enabling the sidebar first when it is absent. Identify that pane by workmux's pane-local `@workmux_role=sidebar` marker rather than its layout position.

Use lowercase `C-a w` for the closest supported worktrees interface: a 100-column by 30-row `workmux dashboard --tab worktrees` popup. Do not define `C-a W` or `C-a L`.

This supersedes the shortcut choices in DECISION-0005.

## Consequences

Agent access goes directly to the live sidebar and remains reliable if the sidebar moves within the window layout. Worktrees still require a popup until workmux adds a dedicated sidebar view. The bindings require workmux on tmux's `PATH`.
