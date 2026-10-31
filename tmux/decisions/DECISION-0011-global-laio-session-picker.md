# DECISION-0011: Global Laio session picker on prefix S

- Status: Accepted
- Date: 2026-10-31

## Context

Laio-managed sessions inject `prefix M-l` for their session picker, but that
shortcut is absent from ordinary tmux sessions. Session management should come
from Laio everywhere, with an uppercase `S` shortcut analogous to tmux's
interactive tree navigation.

Laio 0.18.0 implements its picker as a 50-column by 16-row tmux popup running
`laio start --show-picker`. The picker includes active and available Laio
configurations, switches to an already active selection, and starts an inactive
selection.

## Decision

Bind `C-a S` globally to a tmux popup running `laio start --show-picker`, using
the same dimensions as Laio's runtime-injected binding. Keep lowercase
`C-a w` assigned to the workmux worktree dashboard and retain Laio's injected
`C-a M-l` alias inside Laio-managed sessions.

This supersedes DECISION-0010's choice not to expose the Laio picker in ordinary
tmux sessions. It retains that decision's separation between the tmux binding
and Laio-owned installation and session definitions.

## Consequences

`C-a S` provides one consistent Laio session interface from every tmux session.
The picker depends on `laio` being available on tmux's `PATH`. Native tmux
session/window tree commands remain available through their other bindings, and
the existing workmux and `C-w` navigation shortcuts are unchanged.
