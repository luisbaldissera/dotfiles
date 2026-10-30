# DECISION-0003: Retain the modular lazy.nvim architecture

- Status: Accepted
- Date: 2026-10-30

## Context

The imported configuration already uses a small Lua entry point, lazy.nvim bootstrap, per-plugin specification files, standalone LSP definitions, and shared utilities.

## Decision

Keep lazy.nvim and the existing modular directory responsibilities as the default architecture. Prefer Lua for new work while retaining working legacy Vimscript until a focused migration is justified.

## Consequences

Plugin changes remain isolated and discoverable, and the existing setup can evolve incrementally without a broad rewrite.

