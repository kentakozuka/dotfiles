# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#------------------------------------------------------------------------------#
# Plugin manager
#------------------------------------------------------------------------------#
## Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
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

#-----------------------------------------#
# Plugins
#-----------------------------------------#
zinit light mafredri/zsh-async
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light dracula/zsh

autoload -Uz compinit
compinit

#------------------------------------------------------------------------------#
# modules
#------------------------------------------------------------------------------#
autoload -Uz cdr

#------------------------------------------------------------------------------#
# History
#------------------------------------------------------------------------------#
# history size
HISTSIZE=100000
SAVEHIST=100000
# do not keep duplicated histories
setopt hist_ignore_dups
# delete an old history when duplicated
setopt hist_ignore_all_dups
# write beginning and end time
setopt EXTENDED_HISTORY
# delete spaces that is not necesary
setopt hist_reduce_blanks
# history command is not stored
setopt hist_no_store
# share history between shells
setopt share_history
# write history incrementaly
setopt inc_append_history
# search incrementaly
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

#------------------------------------------------------------------------------#
# path
#------------------------------------------------------------------------------#
PATH=$HOME/.local/bin:/usr/local/bin:$HOME/bin:$PATH
# yvm
export YVM_DIR=$HOME/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# Go
source $HOME/.gvm/scripts/gvm
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$PATH
# Python
if [[ $commands[pyenv] ]]; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi
# Android dev
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH
# Ruby
if [[ -d ~/.rbenv  ]]; then
    export PATH=${HOME}/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
fi
# helmenv
export PATH="$HOME/.helm:$PATH"
source $HOME/.helm/helmenv.sh
# Perl
eval "$(plenv init -)"
# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# MySQL
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# Flutter
export PATH="/Users/s01952/fvm/default/bin:$PATH"
# Java
[ -s "/Users/s01952/.jabba/jabba.sh" ] && source "/Users/s01952/.jabba/jabba.sh"

#------------------------------------------------------------------------------#
# miscellaneous
#------------------------------------------------------------------------------#
bindkey -e
export EDITOR="vim"
# alias
alias ll='ls -laG'
alias bazel='bazelisk'
# bazel
export BAZEL_REMOTE_CACHE=https://storage.googleapis.com/bucketeer-bazel-remote-cache
export BAZEL_REMOTE_CACHE_CREDENTIALS=${HOME}/.config/gcloud/application_default_credentials.json
export BUILD_FLAGS="--remote_http_cache=${BAZEL_REMOTE_CACHE} --google_credentials=${BAZEL_REMOTE_CACHE_CREDENTIALS}"
# kubectl
[ $commands[kubectl] ] && source <(kubectl completion zsh)
# stern completion
source <(stern --completion=zsh)
# gcloud
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
# autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

#------------------------------------------------------------------------------#
# docker
#------------------------------------------------------------------------------#
# kill all volumes
alias dkva='sudo docker volume rm $(sudo docker volume ls -qf dangling=true)'
# stop all containers
alias dsca='sudo docker stop $(sudo docker ps -a -q)'
# kill all containers
alias dkca='sudo docker kill $(sudo docker ps -a -q)'
# remove all containers
alias drca='sudo docker rm $(sudo docker ps -a -q)'

#------------------------------------------------------------------------------#
# git
#------------------------------------------------------------------------------#
alias grv='gh repo view --web'
alias gcm='git checkout master'
alias gt='cd "$(git rev-parse --show-toplevel)"'

#-----------------------------------------#
# gc: checkout with inc search
#-----------------------------------------#
function peco-git-checkout () {
    local branch=$(git branch -a | peco | tr -d ' ')
    if [[ "$branch" =~ "remotes/" ]]; then
        local b=$(echo $branch | awk -F'/' '{for(i=3;i<NF;i++){printf("%s%s",$i,OFS="/")}print $NF}')
        print -z git checkout -b ${b} ${branch}
    else
        print -z git checkout ${branch}
    fi
    CURSOR=$#BUFFER
}
alias gc="peco-git-checkout"

#-----------------------------------------#
# ^g: pick branch with inc search
#-----------------------------------------#
function pick-git-branch {
    local picked=$(git branch | peco | tr -d ' ')
    BUFFER="${BUFFER}${picked}"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N pick-git-branch
bindkey '^g' pick-git-branch

#-----------------------------------------#
# hs: inc search in command history
#-----------------------------------------#
function peco-history-selection() {
    print -z `\history -n 1 | tail -r | peco --layout bottom-up --prompt "[hs]"`
    CURSOR=$#BUFFER
}
alias hs="peco-history-selection"

#-----------------------------------------#
# convimg: convert heic to jpg and remove exif
#-----------------------------------------#
function conv-image() {
    find . -name '*.heic' | xargs -IT basename T .heic | xargs -IT sips --setProperty format jpeg ./T.heic --out ./T.jpg;
    find . -name '*.HEIC' | xargs -IT basename T .HEIC | xargs -IT sips --setProperty format jpeg ./T.HEIC --out ./T.jpg;
    exiftool -all= -overwrite_original *.jpg
}
alias convimg="conv-image"


#------------------------------------------------------------------------------#
# start tmux
#------------------------------------------------------------------------------#
[ $TERM_PROGRAM = "vscode" ] && [[ -z "$TMUX" && ! -z "$PS1" ]] && exec tmux
