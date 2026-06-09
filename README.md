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
brew bundle --file Brewfile
./install.sh
```

The `Brewfile` installs the command-line tools and apps used by this setup. A few larger quality-of-life apps are listed but commented out until you want Homebrew to manage them.

The installer links most tracked configs into the locations the tools expect:

- `~/.zshrc`
- `~/.config/ghostty/config`
- `~/.config/starship.toml`

It copies AeroSpace to `~/.aerospace.toml` instead of symlinking it, because the GUI app may fall back to default bindings when its config is a symlink into `Documents/`.

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
2. Install Homebrew if it is not present.
3. Run `brew bundle --file Brewfile`.
4. Run `./install.sh`.
5. Recreate ignored local files and log into tools manually.
