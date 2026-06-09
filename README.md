# Dotfiles

Small, active config repo for the setup I actually use.

## What Is Tracked

- AeroSpace tiling config: `config/aerospace/aerospace.toml`
- Ghostty terminal config: `config/ghostty/config`
- Starship prompt config: `config/starship/starship.toml`
- Minimal zsh config: `config/zsh/zshrc`
- Public-safe Git config: `config/git/gitconfig`

Private or machine-specific config is intentionally ignored:

- `config/zsh/local.zsh`
- `config/git/gitconfig.local`
- tool auth/state such as Claude, Codex, and profile credentials

## Install

```bash
./install.sh
```

The installer links the tracked configs into the locations the tools expect:

- `~/.zshrc`
- `~/.aerospace.toml`
- `~/.config/ghostty/config`
- `~/.config/starship.toml`

For Git, it writes a small `~/.gitconfig` that includes the tracked config and ignored local config. Existing files are backed up under `~/.dotfiles-backup/<timestamp>/` before being replaced.

## Local Config

Put work-only shell helpers and private machine settings in ignored local files:

```bash
config/zsh/local.zsh
config/git/gitconfig.local
```

Example local Git credential setting:

```ini
[credential]
	helper = osxkeychain
```

## New Laptop Checklist

1. Clone this repo.
2. Install the apps/tools you want, such as AeroSpace, Ghostty, Starship, and zsh-autosuggestions.
3. Run `./install.sh`.
4. Recreate ignored local files and log into tools manually.

