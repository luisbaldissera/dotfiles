# DECISION-0001: Install workmux with Cargo

- Status: Accepted
- Date: 2026-10-30

## Context

workmux supports several installation methods. This Arch Linux setup already has a working Rust and Cargo toolchain, and the requested installation command is `cargo install workmux`.

## Decision

Use `cargo install workmux` as the sole managed installation method. `sync.sh` runs it when neither `workmux` on `PATH` nor Cargo's installed binary is available. When Cargo's binary directory is not on `PATH`, manage a symlink at `~/.local/bin/workmux` instead of editing shell startup files.

## Consequences

The executable is normally installed under Cargo's binary directory and upgrades remain explicit. The sync process requires network access and compilation only when the binary is absent. The PATH-compatible symlink becomes a second managed deployment target.
