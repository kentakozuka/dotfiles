# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
### zsh-history-substring-search
if [ -d "${HOME}/.local/share/fig/plugins/zsh-history-substring-search" ]; then
	source "${HOME}/.local/share/fig/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"
fi
### zsh-autosuggestions
if [ -d "${HOME}/.local/share/fig/plugins/zsh-autosuggestions" ]; then
	source "${HOME}/.local/share/fig/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
### zsh-syntax-highlighting
if [ -d "${HOME}/.local/share/fig/plugins/zsh-syntax-highlighting" ]; then
	source "${HOME}/.local/share/fig/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
### ohmyzsh
if [ -d "${HOME}/.local/share/fig/plugins/ohmyzsh" ]; then
	export ZSH="${HOME}/.local/share/fig/plugins/ohmyzsh"
	source "${HOME}/.local/share/fig/plugins/ohmyzsh/oh-my-zsh.sh"
fi
### materialshell_carloscuesta
if [ -d "${HOME}/.local/share/fig/plugins/materialshell_carloscuesta" ]; then
	source "${HOME}/.local/share/fig/plugins/materialshell_carloscuesta/materialshell.zsh"
fi

function gctx() {
	local select=$(gcloud config configurations list --format='[no-heading]' | awk '{ print $1,$2,$3,$4 }' | column -t | fzf | awk '{ print $1 }')
	print -z gcloud config configurations activate ${select}
}
function convimg() {
	find . -name '*.heic' | xargs -IT basename T .heic | xargs -IT sips --setProperty format jpeg ./T.heic --out ./T.jpg;
	find . -name '*.HEIC' | xargs -IT basename T .HEIC | xargs -IT sips --setProperty format jpeg ./T.HEIC --out ./T.jpg;
	exiftool -all= -overwrite_original *.jpg
}
function hs() {
	print -z `history -n 1 | tac | peco`
	CURSOR=$#BUFFER
}
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
if [[ $commands[gcloud] ]]; then
	source ~/.asdf/installs/gcloud/431.0.0/completion.zsh.inc
	source ~/.asdf/installs/gcloud/431.0.0/path.zsh.inc
fi
[ $commands[kubectl] ] && source <(kubectl completion zsh)
source ~/.asdf/plugins/golang/set-env.zsh
source /opt/homebrew/opt/asdf/libexec/asdf.sh
eval $(/opt/homebrew/bin/brew shellenv)

source $(brew --prefix asdf)/libexec/asdf.sh
alias -- grv='gh repo view --web'
alias -- gc='git commit -s'
export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)
export PATH=$PATH:$GOPATH/bin
PATH="$PATH:"''
alias -- gt='cd "$(git rev-parse --show-toplevel)"'
alias -- ll='ls -laG'
alias -- kb='kubectl'
alias -- gch='git checkout'
autoload -Uz compinit
compinit


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
