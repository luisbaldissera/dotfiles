# Laio tmux sessions

This component installs Laio 0.18.0 as a local Arch package and manages the
global template used by `laio config create`.

Preview the repository-to-system changes:

```bash
./laio/sync.sh --dry-run
```

Deploy only when installation and configuration changes are intended:

```bash
./laio/sync.sh
```

The live sync builds the pinned upstream binary release with `makepkg` and
installs it through Pacman. It then deploys `config/_default.yaml` to
`${XDG_CONFIG_HOME:-~/.config}/laio/_default.yaml`.

Create and start a global session rooted at the current project:

```bash
laio config create myproject
laio config validate myproject
laio start myproject
```

For a session definition that travels with a project, create `.laio.yaml` in
that project's root and commit it there:

```bash
laio config create
laio config validate --file .laio.yaml
laio start
```

Laio uses tmux by default. Within a Laio-started tmux session, `C-a M-l`
opens Laio's session switcher because this repository's tmux prefix is `C-a`.
Named configs, local `.laio.yaml` files, session state, and tmux sockets are not
managed by this component.
