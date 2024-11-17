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
# source zsh-syntax-highlighting
#=============================
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#=============================
# source zsh-autosuggestions
#=============================
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
	source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

#=============================
# source zsh-completions
#=============================
if [ -f ~/.zsh/zsh-completions/zsh-completions.zsh ]; then
	source ~/.zsh/zsh-completions/zsh-completions.zsh
fi

#=============================
# source zsh-history-substring-search
#=============================
if [ -f ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
	source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

# color

# 下線を削除するために、zsh-syntax-highlightingのスタイルを設定
ZSH_HIGHLIGHT_STYLES[path]='none'

# コマンドの色を設定
for style in command builtin reserved-word alias function; do
	ZSH_HIGHLIGHT_STYLES[$style]='fg=#B2BD79'
done

# ------ キーバインド -----------------------

# fzfでディレクトリをファジー検索して移動

# fzfファジー検索
EXCLUDE_PATHS="-path './.config/*' -o -path './.config' -a ! -path '*/library/*'"

fcd() {
	local dir
	dir=$(find . -type d \( ! -path '*/.*' ${EXCLUDE_PATHS} \) | fzf) && cd "$dir"
}

fnv() {
	local dir
	dir=$(find . -type d \( ! -path '*/.*' ${EXCLUDE_PATHS} \) | fzf) && nvim "$dir"
}

# bindkey '^I' autosuggest-accept

alias nv='nvim'
alias cl='clear'
# alias dt="LC_TIME=ja_JP.UTF-8 date '+%Y/%m/%d %a %y%m%d'"
alias dt="echo '\033[1;34m'$(date '+%Y/%m/%d')'\033[0m'"

# --------------------------------------------

# ~/.zshrcの中で.zprofileを読み込む
# gitに乗っけられないプラグイン
if [ -f ~/.zprofile ]; then
	source ~/.zprofile
fi
