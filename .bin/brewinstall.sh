#!/usr/bin/env zsh
set -ue

# Homebrewで必要なツールをインストール
install_tools() {
  echo "Installing tools with Homebrew..."

  # Homebrew自体がインストールされていない場合はインストール
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # 必要なツールのインストール
  brew update
  brew install trash

  echo "Tools installation completed!"
}

install_tools
