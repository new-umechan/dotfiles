#!/bin/bash
set -ue

PLUGIN_DIR="$HOME/.dotfiles/.zsh"

# Zinitのインストール関数
install_zinit() {
    local zinit_dir="${HOME}/.zinit/bin"
    if [ ! -d "$zinit_dir" ]; then
        echo "Installing Zinit..."
        sh -c "$(curl -fsSL https://git.io/zinit-install)"
    else
        echo "Zinit is already installed at $zinit_dir"
    fi
}

# Zinitを使ったプラグインの設定関数
setup_zinit_plugins() {
    local zshrc="${HOME}/.zshrc"

    # Zinit初期化スクリプトを.zshrcに追加
    if ! grep -q "source ~/.zinit/bin/zinit.zsh" "$zshrc"; then
        echo "Adding Zinit initialization to .zshrc..."
        cat <<EOF >>"$zshrc"

# Zinit initialization
source ~/.zinit/bin/zinit.zsh

# Plugins managed by Zinit
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search
EOF
    else
        echo "Zinit initialization already exists in .zshrc"
    fi
}

# Main script
echo "Setting up Zinit and plugins..."
install_zinit
setup_zinit_plugins

print -e "\e[1;36m Zinit and plugins setup successfully! Please restart your terminal or run 'source ~/.zshrc' to apply the changes. \e[m"
