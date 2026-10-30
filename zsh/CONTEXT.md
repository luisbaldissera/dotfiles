# Zsh context

Last baseline import: 2026-10-30 from `~/.zprofile` and `~/.zshrc` on Arch Linux.

## Managed paths

- Repository source: `config/zprofile`
- System destination: `~/.zprofile`
- Repository source: `config/zshrc`
- System destination: `~/.zshrc`
- Deployment: `sync.sh`
- Zsh version observed at import: 5.9.2

No `~/.zshenv`, `~/.zlogin`, `~/.zlogout`, or `~/.config/zsh/` directory was present at import. The sync script does not create or delete those paths.

## Current behavior

- Oh My Zsh is loaded from `~/.oh-my-zsh` with the `robbyrussell` theme.
- Enabled Oh My Zsh plugins are `git`, `taskwarrior`, `pyenv`, and `nvm`.
- `nvim` is the default editor. `lg` invokes `lazygit`, and `osv` starts Neovim's OSV server.
- NVM loads from `~/.nvm` and selects the stable Node.js release, installing it when unavailable.
- rbenv initializes Ruby support for Zsh. pyenv initializes login-shell PATH handling from `.zprofile`.
- PATH additions cover the user's pipx binaries, JDT Language Server, LemMinX, Go, and CUDA.
- `LIBVIRT_DEFAULT_URI` selects the system libvirt connection.
- An optional untracked `${XDG_CONFIG_HOME:-$HOME/.config}/zsh/secrets.zsh` is sourced last when readable.

## Security and operational notes

- The imported `.zshrc` contained plaintext service credentials. Their values were deliberately excluded from the repository and must be revoked and replaced outside Git.
- `secrets.example.zsh` documents the local secrets-file convention without containing credentials.
- `~/.zsh_history`, `.zcompdump*`, Oh My Zsh itself, NVM/rbenv/pyenv installations, caches, and downloaded plugins are runtime or installed state and remain unmanaged.
- `sync.sh` updates only the two explicitly managed startup files. It does not mirror or delete unrelated Zsh files.

