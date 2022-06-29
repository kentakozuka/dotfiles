# Plugin manager
# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh  # Start Znap

# `znap source` automatically downloads and starts your plugins.
znap source mafredri/zsh-async
znap source zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'
znap source zsh-users/zsh-syntax-highlighting
znap source kentakozuka/dotfiles zsh/utils
znap source kentakozuka/dotfiles zsh/theme

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

bindkey -e
export EDITOR="vim"

#------------------------------------------------------------------------------#
# Command specific settings
#------------------------------------------------------------------------------#
# yvm
[ -r $HOME/.yvm/yvm.sh ] && . $HOME/.yvm/yvm.sh
# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# Go
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
[[ $commands[goenv] ]] && eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
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
[[ $commands[rbenv] ]] && eval "$(rbenv init -)"
# helmenv
[[ $commands[helmenv] ]] && eval $(export PATH="$(brew --prefix)/bin/:$PATH")
# Perl
[[ $commands[plenv] ]] && eval "$(plenv init -)"
# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# MySQL
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# Flutter
export PATH="$HOME/fvm/default/bin:$PATH"
# Java
[ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"
# Rust
[[ -s $HOME/.cargo/env ]] && source $HOME/.cargo/env
export CARGO_NET_GIT_FETCH_WITH_CLI=true
# kubectl
[ $commands[kubectl] ] && source <(kubectl completion zsh)
# gcloud
if [[ $commands[gcloud] ]]; then
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi
# Alias
alias grv='gh repo view --web'
alias gcm='git checkout master'
alias gt='cd "$(git rev-parse --show-toplevel)"'
alias ll='ls -laG'
alias bazel='bazelisk'

#------------------------------------------------------------------------------#
# start tmux
#------------------------------------------------------------------------------#
if [ -n "${REMOTE_CONTAINERS+1}" ]; then
    echo "I'm in a remote container"
else
    echo "I'm NOT in a remote container"
    [ $TERM_PROGRAM = "vscode" ] && [[ $commands[tmux] ]] && [[ -z "$TMUX" && ! -z "$PS1" ]] && exec tmux
fi
