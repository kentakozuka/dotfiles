# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"


[[ -f "$HOME/.oh-my-zsh" ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
export ZSH="$HOME/.oh-my-zsh"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

ZSH_THEME="robbyrussell"
plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# Custom functions
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
# completion
# autoload -Uz compinit
# compinit
# emacs mode
bindkey -e
# vim as a default editor
export EDITOR="vim"

if [ "$(uname)" = "Darwin" ] ; then
	source ~/.asdf/plugins/golang/set-env.zsh
	source /opt/homebrew/opt/asdf/libexec/asdf.sh
	eval $(/opt/homebrew/bin/brew shellenv)
	source $(brew --prefix asdf)/libexec/asdf.sh
fi

alias -- gc='git commit -s -m'
alias -- gco='git checkout'
alias -- ghpr='gh pr view --web'
alias -- ghrp='gh repo view --web'
alias -- gt='cd "$(git rev-parse --show-toplevel)"'
alias -- ll='ls -laG'
export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)
export PATH=$PATH:$GOPATH/bin
PATH="$PATH:"''

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
