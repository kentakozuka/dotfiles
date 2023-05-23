# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Fig pre block. Keep at the top of this file.

#------------------------------------------------------------------------------#
# Zsh settings
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
# emacs mode
bindkey -e
# vim as a default editor
export EDITOR="vim"

#------------------------------------------------------------------------------#
# Command specific settings
#------------------------------------------------------------------------------#
# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)
# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.sh
# Go
source ~/.asdf/plugins/golang/set-env.zsh
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
# Android dev
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH
# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# MySQL
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# Flutter
export PATH="$HOME/fvm/default/bin:$PATH"
# Rust
[[ -s $HOME/.cargo/env ]] && source $HOME/.cargo/env
export CARGO_NET_GIT_FETCH_WITH_CLI=true
# kubectl
[ $commands[kubectl] ] && source <(kubectl completion zsh)
# gcloud
if [[ $commands[gcloud] ]]; then
    source ~/.asdf/installs/gcloud/431.0.0/completion.zsh.inc
    source ~/.asdf/installs/gcloud/431.0.0/path.zsh.inc
fi
# Alias
alias grv='gh repo view --web'
alias gcm='git checkout master'
alias gt='cd "$(git rev-parse --show-toplevel)"'
alias ll='ls -laG'
alias kb='kubectl'

#-----------------------------------------#
# gctx
#-----------------------------------------#
function gcloud-config-select() {
    local select=$(gcloud config configurations list --format='[no-heading]' | awk '{ print $1,$2,$3,$4 }' | column -t | fzf | awk '{ print $1 }')
    print -z gcloud config configurations activate ${select}
}
alias gctx="gcloud-config-select"

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
    print -z `history -n 1 | tac | peco --layout bottom-up --prompt "[hs]"`
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
# [ $TERM_PROGRAM = "vscode" ] && [[ $commands[tmux] ]] && [[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
