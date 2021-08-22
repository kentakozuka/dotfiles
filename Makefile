.PHONY: zsh vim vscode tmux karabiner git ssh

zsh:
	ln -sf ${PWD}/zsh/.zshrc ${HOME}/.zshrc

vim:
	ln -sf ${PWD}/vimrc/.vimrc ${HOME}/.vimrc

vscode:
	source ${PWD}/vscode/install_extensions.sh
	ln -sf ${PWD}/vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json

tmux:
	ln -sf ${PWD}/tmux/.tmux.conf ${HOME}/.tmux.conf
	ln -sf ${$GOPATH}/src/github.com/jonmosco/kube-tmux ${HOME}/.tmux/

karabiner:
	ln -sf ${PWD}/config/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json

git:
	ln -sf ${PWD}/git/.gitconfig ${HOME}/.gitconfig

ssh:
	ln -sf ${PWD}/ssh/config ${HOME}/.ssh/config