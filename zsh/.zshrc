# Plugin manager
# https://github.com/zpm-zsh/zpm
if [[ ! -f ~/.zpm/zpm.zsh ]]; then
    git clone --recursive https://github.com/zpm-zsh/zpm ~/.zpm
fi
source ~/.zpm/zpm.zsh
# Plugins
zpm load mafredri/zsh-async,source:async.plugin.zsh
zpm load @github/zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'
zpm load @github/zsh-users/zsh-completions,source:zsh-completions.plugin.zsh
zpm load @github/zsh-users/zsh-syntax-highlighting,source:zsh-syntax-highlighting.zsh
zpm load @github/dracula/zsh,source:dracula.zsh-theme

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

bindkey -e
export EDITOR="vim"

#------------------------------------------------------------------------------#
# Command specific settings
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

alias ll='ls -laG'
alias bazel='bazelisk'

# kubectl
[ $commands[kubectl] ] && source <(kubectl completion zsh)
# gcloud
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# git
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
# conv-image: convert heic to jpg and remove exif
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
