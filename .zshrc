export ZSH="/Users/keisuke/.oh-my-zsh"
ZSH_THEME="agnoster"

export LANG="ja_JP.UTF-8"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# Paths
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Ruby
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Node
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
eval "$(nodenv init -)"

# Go
export GO111MODULE=on
export GOENV_ROOT=$HOME/.goenv
export GOPATH=$HOME/dev/go
export PATH=$GOPATH/bin:$PATH
export PATH=$GOENV_ROOT/bin:$PATH
export PATH=$HOME/.goenv/bin:$PATH
eval "$(goenv init -)"

# Terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

#######################################

# Google Cloud
alias gc='gcloud'

# Ruby
alias be='bundle exec'
alias bers='bundle exec rails s'
alias bejs='bundle exec jets s'
alias berg='bundle exec rails g'
alias bi='bundle install --path=vendor/bundle'

# Docker
alias de='docker exec -it'
alias dp='docker ps'
alias dpa='docker ps -a'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose up -d'
alias dcr='docker-compose run'
alias dcb='docker-compose build'
alias di='docker images'

# JS
alias y='yarn'
alias yl='yarn lint --fix'
alias yd='yarn dev'
alias yb='yarn build'

# git
alias g='git'
alias ga='git add .'
alias gj='git add . && git commit -am'
alias gg='git commit -m'
alias gid='git diff'
alias gis='git status'
alias gll='git log'
alias gpu='git pull origin HEAD'
alias gpp='git push origin HEAD'
alias gre='git reset --soft HEAD\^'
alias gri='git rebase -i'

# k8s
alias k='kubectl'
alias kge='kubectl get'
alias kap='kubectl apply -f'

# dir
alias des='cd ~/Desktop && ls -l'
alias dev='cd ~/Dev/ && ls -l'
alias ..='cd ../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias la='ls -a'
alias ll='ls -l'
alias l='ls -a -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# global
alias pg='ps ax | grep'
alias -g L='| less'
alias -g G='| grep'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# 色を使用出来るようにする
export BAT_THEME="Monokai Extended Bright"
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
PROMPT="%{${fg[green]}%}%{${reset_color}%} %~
%# "

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

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

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac
