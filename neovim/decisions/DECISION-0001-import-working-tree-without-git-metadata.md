# DECISION-0001: Import the working tree without Git metadata

- Status: Accepted
- Date: 2026-10-30

## Context

`~/.config/nvim` was already a Git repository with local modifications, deletions, untracked content, and ignored files that affect the live setup.

## Decision

Import the complete on-disk working tree, including ignored and untracked files, but exclude the nested `.git/` directory.

## Consequences

The new repository accurately captures the live baseline without embedding another repository's object database or remote metadata. The prior working-tree state is documented in `CONTEXT.md`.

