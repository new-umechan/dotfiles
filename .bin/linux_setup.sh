#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"

link_item() {
  local src="$1"
  local dest="$2"

  if [ ! -e "$src" ]; then
    echo "skip: source not found: $src"
    return
  fi

  mkdir -p "$(dirname "$dest")"

  if [ -L "$dest" ]; then
    local current
    current="$(readlink "$dest")"
    if [ "$current" = "$src" ]; then
      echo "ok: already linked: $dest -> $src"
      return
    fi
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "backup: $dest -> $BACKUP_DIR/"
    mv "$dest" "$BACKUP_DIR/"
  fi

  ln -s "$src" "$dest"
  echo "link: $dest -> $src"
}

if [ "$(uname)" != "Linux" ]; then
  echo "This script is intended for Linux only."
  exit 1
fi

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "dotfiles directory not found: $DOTFILES_DIR"
  exit 1
fi

mkdir -p "$HOME/.config"

# Shell
link_item "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_item "$DOTFILES_DIR/.zsh" "$HOME/.zsh"
link_item "$DOTFILES_DIR/.codex" "$HOME/.codex"
link_item "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Editor
link_item "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

export COLORTERM=truecolor

sudo apt install -y build-essential make gcc g++ cmake unzip curl git ripgrep fd-find nodejs npm
sudo apt install -y trash-cli lazygit

echo
echo "Done."
echo "Restart shell with:"
echo "  exec zsh"
