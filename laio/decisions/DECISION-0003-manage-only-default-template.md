# DECISION-0003: Manage only the global creation template

- Status: Accepted
- Date: 2026-10-31

## Context

Laio supports global named configurations as well as project-local `.laio.yaml` files. Mirroring the entire global configuration directory would risk deleting or overwriting sessions created interactively or linked from projects.

## Decision

Manage only `config/_default.yaml` and deploy it to Laio's global configuration directory. Use the auto-injected `session_name` and `path` variables so `laio config create NAME` creates a session rooted at the current project.

Keep named global configurations and project-local files outside the component's sync boundary. Make configuration deployment one-way, backup changed destinations by default, and support a mutation-free dry run.

## Consequences

The repository provides a consistent personal starting layout without claiming ownership of every session definition. Per-project layouts remain reviewable in their respective repositories, while personal named sessions can change independently.
