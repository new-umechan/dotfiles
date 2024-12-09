source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

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
# # source zsh-syntax-highlighting
# #=============================
# if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
# 	source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fi
#
# #=============================
# # source zsh-autosuggestions
# #=============================
# if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
# 	source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# fi
#
# #=============================
# # source zsh-completions
# #=============================
# if [ -f ~/.zsh/zsh-completions/zsh-completions.zsh ]; then
# 	source ~/.zsh/zsh-completions/zsh-completions.zsh
# fi
#
# #=============================
# # source zsh-history-substring-search
# #=============================
# if [ -f ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
# 	source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# fi

#=============================
# zsh-syntax-highlighting（遅延ロード）
#=============================
zinit ice wait"2"
zinit light zsh-users/zsh-syntax-highlighting

#=============================
# zsh-autosuggestions（遅延ロード + キーバインド設定）
#=============================
zinit ice wait"1" atload"bindkey '^E' autosuggest-accept"
zinit light zsh-users/zsh-autosuggestions

#=============================
# zsh-completions（即時ロード）
#=============================
zinit ice wait"0"
zinit light zsh-users/zsh-completions

#=============================
# zsh-history-substring-search（特定キーでロード）
#=============================
zinit ice atload"bindkey '^R' history-substring-search-up; bindkey '^S' history-substring-search-down"
zinit light zsh-users/zsh-history-substring-search

# ------ キーバインド -----------------------

# fzfでディレクトリをファジー検索して移動

# fzfファジー検索

fcd() {
	local dir
	dir=$(find . -type d | fzf) && cd "$dir"
}

alias nv='nvim'
alias cl='clear'
# alias dt="LC_TIME=ja_JP.UTF-8 date '+%Y/%m/%d %a %y%m%d'"
alias dt="echo '\033[1;34m'$(date '+%Y/%m/%d')'\033[0m'"

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

# 全ての設定が終わってから
bindkey '^[[A' history-substring-search-up    # 上矢印キーで履歴を上に移動
bindkey '^[[B' history-substring-search-down  # 下矢印キーで履歴を下に移動
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"
eval "$(pyenv init --path)"
export PATH="$HOME/.gem/ruby/3.2.6/bin:$PATH"
export PATH="/Users/umehararyu/.rbenv/versions/3.2.6/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.2.0/bin:$PATH"
