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

# プラグイン（遅延ロード）

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# 速度のため、既存プラグインを手動で読み込む
[ -f "$HOME/.zprezto/modules/autosuggestions/external/zsh-autosuggestions.zsh" ] \
    && source "$HOME/.zprezto/modules/autosuggestions/external/zsh-autosuggestions.zsh"
[ -f "$HOME/.zprezto/modules/history-substring-search/external/zsh-history-substring-search.zsh" ] \
    && source "$HOME/.zprezto/modules/history-substring-search/external/zsh-history-substring-search.zsh"
(( ${+functions[_zsh_autosuggest_bind_widgets]} )) && _zsh_autosuggest_bind_widgets

__load_syntax_highlighting_once() {
  local f="$HOME/.zprezto/modules/syntax-highlighting/external/zsh-syntax-highlighting.zsh"
  [ -f "$f" ] || return
  source "$f"
  (( ${+functions[_zsh_highlight_bind_widgets]} )) && _zsh_highlight_bind_widgets
  add-zsh-hook -d precmd __load_syntax_highlighting_once
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd __load_syntax_highlighting_once

# 補完設定

fpath=(~/.zsh/completions $fpath)

autoload -Uz compinit
compinit -C

# 補完メニュー
zstyle ':completion:*' menu select
zstyle ':completion:*' list-separator ' ─ '
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}no matches: %d%f'

# 大文字小文字無視 + 部分一致 + 記号ゆるめ
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# 候補の色
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# プロセス補完を見やすく
zstyle ':completion:*:*:(kill|ps):*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# cd 補完を強化
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:cd:*' ignore-parents parent pwd ..

# sudo の後ろでもコマンド補完
zstyle ':completion:*:sudo:*' command-path \
  /opt/homebrew/bin /opt/homebrew/sbin \
  /usr/local/bin /usr/local/sbin \
  /usr/bin /usr/sbin /bin /sbin

# キャッシュで少し高速化
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Tab
bindkey '^I' expand-or-complete

_smart_ctrl_e() {
  if (( CURSOR == $#BUFFER )); then
	if [[ -n "$POSTDISPLAY" ]]; then
	  zle autosuggest-accept
	  return
	fi
  fi

  zle end-of-line
}
zle -N _smart_ctrl_e
bindkey '^E' _smart_ctrl_e

# ------ キーバインド -----------------------

_nv_files() {
  _files
}
compdef _nv_files nv

tree() {
  [ -d .git ] && eza --tree --git-ignore "$@" || eza --tree "$@"
}

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

# brew --prefixは重いため、絶対パスに固定
z() {
  unfunction z
  . /opt/homebrew/etc/profile.d/z.sh
  z "$@"
}

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

export PATH="/Users/umehararyu/.antigravity/antigravity/bin:$PATH"
export OLLAMA_MODELS="/Volumes/ssd/ollama-models"

# zprof
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# pnpm
export PNPM_HOME="/Users/umehararyu/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
