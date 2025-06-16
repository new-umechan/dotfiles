source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# ロード時間をzprofで
zmodload zsh/zprof

PROMPT='%~ > '
RPROMPT=''

plugins=(git)

# noramly setting

# 色を使用出来るようにする
autoload -Uz colors
colors

# lsをしたときに、色をつけるようにする
alias ls='ls --color=auto'

# emacs 風キーバインドにする
# vimよりも、１行とかのコードだと便利
bindkey -e

# ディレクトリ名だけでcdする
# setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups


# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
	/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
	########################################

#=============================
# zsh-syntax-highlighting（遅延ロード）
#=============================
zinit ice wait"2"
zinit light zsh-users/zsh-syntax-highlighting

#=============================
# zsh-autosuggestions（遅延ロード + キーバインド設定）
#=============================
zinit ice wait"1"
zinit light zsh-users/zsh-autosuggestions

#=============================
# zsh-completions（即時ロード）
#=============================
zinit ice wait"0"
zinit light zsh-users/zsh-completions

# ------ キーバインド -----------------------

alias nv='nvim'
alias cl='clear'

function mdcd() {
    mkdir -p "$1" && cd "$1"
}

function tonv() {
    local file="$1"
    mkdir -p "$(dirname "$file")" && touch "$file" && nvim "$file"
}

# --------------------------------------------

# ~/.zshrcの中で.zprofileを読み込む
# gitに乗っけられないプラグイン
if [ -f ~/.zprofile ]; then
	source ~/.zprofile
fi

# プラグインディレクトリ
PLUGIN_DIR="$HOME/.dotfiles/.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Plugins managed by Zinit
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search

. `brew --prefix`/etc/profile.d/z.sh

# color

# 下線を削除するために、zsh-syntax-highlightingのスタイルを設定
ZSH_HIGHLIGHT_STYLES[path]='none'

# コマンドの色を設定
for style in command builtin reserved-word alias function; do
	ZSH_HIGHLIGHT_STYLES[$style]='fg=#B2BD79'
done

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"
eval "$(pyenv init --path)"
export PATH="$HOME/.gem/ruby/3.2.6/bin:$PATH"
export PATH="/Users/umehararyu/.rbenv/versions/3.2.6/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.2.0/bin:$PATH"
export DYLD_LIBRARY_PATH=/opt/homebrew/lib:$DYLD_LIBRARY_PATH
export COHERE_API_KEY=sa6UM1hXNquEeH3fntaGGgrYEjGVUXbmCTTRdJdf
export LINE_CHANNEL_SECRET="2a2f079801fd207fd1295e11f090c4c4"
export MSG_CHANNEL_ACCESS_TOKEN="xh3hao4glxchg8DVAPZzoJgHLYUbMfdIO8bj/tb5Tq/D92bzzdxPa44UCGNoHSFHHdUT3u10Y0BoBzZdVNaNw5EKu3ajGSzOObkYu7qmNX+btnDS9QoaqbB1finH3CDfJZjsrCdfuBdACjwx1NM/nwdB04t89/1O/w1cDnyilFU="

# Created by `pipx` on 2025-01-17 09:52:54
export PATH="$PATH:/Users/umehararyu/.local/bin"

# g++　c++競プロ用
export "PATH=/usr/local/bin:$PATH"
