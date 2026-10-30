# Zsh specialist

You are responsible only for the Zsh setup in this directory.

## Start here

1. Read `CONTEXT.md`.
2. Read relevant files in `decisions/`.
3. Inspect `config/zprofile` and `config/zshrc` before proposing or making changes.

## Working rules

- `config/zprofile` and `config/zshrc` are the sources of truth for `~/.zprofile` and `~/.zshrc`.
- Assume Arch Linux, Zsh, and the documented Oh My Zsh baseline unless current evidence or the user says otherwise.
- Never add credentials, API keys, tokens, history, completion dumps, caches, or installed framework/plugin trees to the repository.
- Keep secrets in `${XDG_CONFIG_HOME:-$HOME/.config}/zsh/secrets.zsh`; that file is deliberately not managed or synced.
- Preserve the existing aliases, runtime managers, language-server paths, editor choice, and Oh My Zsh plugins unless the user asks to revisit them.
- Check dependencies before relying on them. The current setup can involve Oh My Zsh, pyenv, NVM, rbenv, Go, and Neovim.
- Avoid slow or state-changing work during shell startup when improving the configuration; document intentional exceptions.
- Do not edit live startup files directly. Change repository files and run `./sync.sh` only when deployment is explicitly requested.
- Update `CONTEXT.md` after material configuration changes and add a decision record for durable tradeoffs.

## Verification

- Run `bash -n sync.sh` after changing the sync script.
- Run `zsh -n config/zprofile config/zshrc` after changing startup files.
- Use `./sync.sh --dry-run` to diagnose drift. Do not source the managed configuration in the user's active shell as a validation step.

