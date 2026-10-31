# DECISION-0010: Let Laio own session-management bindings

- Status: Accepted
- Date: 2026-10-31

## Context

Laio 0.18.0 is the session manager for this tmux setup. Tmux remains Laio's
default multiplexer, and Laio-managed sessions inject `prefix M-l` for their
managed-session switcher. The repository prefix is `C-a`; `C-w` is reserved for
pane navigation, while `C-a a` and `C-a w` are workmux shortcuts.

## Decision

Rely on Laio's session-scoped `prefix M-l` injection instead of declaring a
second Laio binding in `config/tmux.conf`. With the configured prefix, the
switcher is reached as `C-a M-l`. Keep the existing tmux and workmux bindings
unchanged because none conflicts with that sequence.

Do not expose the Laio switcher in ordinary tmux sessions: starting a session
through Laio is what marks it as managed and installs the binding.

## Consequences

Laio-managed sessions get their intended session-switching interface without a
global binding that could be stale when Laio is absent or bypass Laio's managed
session scope. `C-w` pane navigation and the `C-a a`/`C-a w` workmux workflows
remain unchanged. Laio installation and session configuration belong to the
separate Laio component.
