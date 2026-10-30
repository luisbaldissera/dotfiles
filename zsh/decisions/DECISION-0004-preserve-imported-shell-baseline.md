# DECISION-0004: Preserve the imported shell baseline

- Status: Accepted
- Date: 2026-10-30

## Context

The current startup files encode an established interactive environment spanning Oh My Zsh, runtime managers, editor aliases, language-server paths, Go, CUDA, pipx, and libvirt.

## Decision

Keep that behavior as the initial managed baseline, except for extracting plaintext credentials. Treat performance, portability, and version-pinning improvements as subsequent explicit changes.

## Consequences

The first import minimizes behavioral surprise. Existing characteristics such as selecting or installing stable Node.js during interactive startup remain visible and can be reviewed deliberately later.

