# DECISION-0003: Preserve the Vim and Wayland baseline

- Status: Accepted
- Date: 2026-10-30

## Context

The imported configuration already expresses an intentional interaction model and desktop environment integration.

## Decision

Retain the `C-w` prefix, Vim pane/copy bindings, current-directory splits, `wl-copy` integration, and TPM plugin baseline until a later requirement supersedes them.

## Consequences

Future changes should compose with these bindings and explicitly document incompatible remappings or non-Wayland fallbacks.

