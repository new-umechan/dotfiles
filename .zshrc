source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# ロード時間をzprofで
zmodload zsh/zprof

PROMPT='%~ > '
RPROMPT=''

# noramly setting

# lsをしたときに、色をつけるようにする
alias ls='ls --color=auto'

# emacs 風キーバインドにする
# vimよりも、１行とかのコードだと便利
bindkey -e

bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey '^u' push-line

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^o' edit-command-line

export EDITOR=nvim

# ディレクトリ名だけでcdする
# setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups


# 同時に起動したzshの間でヒストリを共有する
# setopt share_history

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit

__lazy_compinit() {
  compinit -C
  bindkey '^I' expand-or-complete
  zle expand-or-complete
}

zle -N __lazy_compinit
bindkey '^I' __lazy_compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
	/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
	########################################

#=============================
# プラグイン（遅延ロード）
#=============================

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

zinit ice wait'1' lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait'1' lucid
zinit light zsh-users/zsh-history-substring-search

zinit ice wait'1' lucid atload'_zsh_highlight_bind_widgets; _zsh_autosuggest_bind_widgets'
zinit light zsh-users/zsh-syntax-highlighting

# ------ キーバインド -----------------------

alias nv='nvim'

alias shogun="~/prog/tools/multi-agent-shogun/shutsujin_departure.sh -c"

alias tree="eza --tree --git-ignore"


function mkcd() {
    mkdir -p "$1" && cd "$1"
}

uvcd() {
	if [ -z "$1" ]; then
		echo "使い方: uvcd <project_name>"
		return 1
	fi

	local project="$1"

	# すでに存在してたらエラー出す
	if [ -e "$project" ]; then
		echo "⚠️ ディレクトリ '$project' はすでに存在します。"
		return 1
	fi

	# ディレクトリ作成して移動
	mkdir -p "$project"
	cd "$project" || return 1

	uv init

	# pyrightconfig.json 追加
	cat <<EOF > pyrightconfig.json
{
  "venvPath": ".",
  "venv": ".venv"
}
EOF
}


p5init() {
  cp -- "$HOME/.config/p5_temp"/{index.html,sketch.js,package.json} . \
    && npm i -D vite
}

# --------------------------------------------

# ~/.zshrcの中で.zprofileを読み込む
# gitに乗っけられないプラグイン
if [ -f ~/.zprofile ]; then
	source ~/.zprofile
fi

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# brew --prefixは重いため、絶対パスに固定
. /opt/homebrew/etc/profile.d/z.sh

# color

# 下線を削除するために、zsh-syntax-highlightingのスタイルを設定
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='none'

# コマンドの色を設定
for style in command builtin reserved-word alias function; do
	ZSH_HIGHLIGHT_STYLES[$style]='fg=#B2BD79'
done

export PATH="$HOME/.rbenv/bin:$PATH"

# pyenv / rbenv は重いため、PATHだけ通してコマンド実行時に初期化する
export PATH="$HOME/.rbenv/shims:$HOME/.pyenv/shims:$PATH"
rbenv() { unset -f rbenv; eval "$(command rbenv init - zsh)"; rbenv "$@" }
pyenv() { unset -f pyenv; eval "$(command pyenv init - zsh)"; pyenv "$@" }

export PATH="$HOME/.gem/ruby/3.2.6/bin:$PATH"
export PATH="/Users/umehararyu/.rbenv/versions/3.2.6/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.2.0/bin:$PATH"
export DYLD_LIBRARY_PATH=/opt/homebrew/lib:$DYLD_LIBRARY_PATH

# Created by `pipx` on 2025-01-17 09:52:54
export PATH="$PATH:/Users/umehararyu/.local/bin"

# npm用
export PATH=$HOME/.local/bin:$PATH

# g++　c++競プロ用
export "PATH=/usr/local/bin:$PATH"

# APIキーなどの秘密情報を読み込む
# ファイルが存在する場合のみ読み込むことで、他の環境でのエラーを防ぐ
if [ -f ~/.api_keys ]; then
    source ~/.api_keys
fi
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# Added by Antigravity
export PATH="/Users/umehararyu/.antigravity/antigravity/bin:$PATH"

zprof
