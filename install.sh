#!/usr/bin/env bash
# Link this repo's active configuration files into the home directory.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

backup_path() {
  local target="$1"
  local rel="${target#$HOME/}"
  printf '%s/%s\n' "$BACKUP_DIR" "$rel"
}

link_file() {
  local source="$1" target="$2"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    printf 'Already linked: %s\n' "$target"
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    local backup
    backup="$(backup_path "$target")"
    mkdir -p "$(dirname "$backup")"
    mv "$target" "$backup"
    printf 'Backed up %s -> %s\n' "$target" "$backup"
  fi

  ln -s "$source" "$target"
  printf 'Linked %s -> %s\n' "$target" "$source"
}

write_gitconfig() {
  local target="$HOME/.gitconfig"
  local local_config="$SCRIPT_DIR/config/git/gitconfig.local"

  touch "$local_config"

  if [ -e "$target" ] || [ -L "$target" ]; then
    if grep -qF "$SCRIPT_DIR/config/git/gitconfig" "$target" 2>/dev/null; then
      printf 'Already configured: %s\n' "$target"
      return
    fi

    local backup
    backup="$(backup_path "$target")"
    mkdir -p "$(dirname "$backup")"
    mv "$target" "$backup"
    printf 'Backed up %s -> %s\n' "$target" "$backup"
  fi

  cat > "$target" <<EOF
[include]
	path = $SCRIPT_DIR/config/git/gitconfig
[include]
	path = $local_config
EOF
  printf 'Wrote %s\n' "$target"
}

link_file "$SCRIPT_DIR/config/zsh/zshrc" "$HOME/.zshrc"
link_file "$SCRIPT_DIR/config/aerospace/aerospace.toml" "$HOME/.aerospace.toml"
link_file "$SCRIPT_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
link_file "$SCRIPT_DIR/config/starship/starship.toml" "$HOME/.config/starship.toml"
write_gitconfig

printf '\nDone. Restart your shell, or run: exec zsh\n'

