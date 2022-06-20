.PHONY: list-extensions
list-extensions:
	${PWD}/vscode/list-extensions.sh

.PHONY: zsh
zsh:
	ln -sf ${PWD}/zsh/.zshrc ${HOME}/.zshrc

.PHONY: vscode
vscode:
	source ${PWD}/vscode/install_extensions.sh
	ln -sf ${PWD}/vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json

.PHONY: tmux
tmux:
	ln -sf ${PWD}/tmux/.tmux.conf ${HOME}/.tmux.conf
	ln -sf ${PWD}/tmux/status.sh ${HOME}/.tmux/status.sh

.PHONY: karabiner
karabiner:
	ln -sf ${PWD}/config/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json

.PHONY: git
git:
	ln -sf ${PWD}/git/.gitconfig ${HOME}/.gitconfig

.PHONY: ssh
ssh:
	ln -sf ${PWD}/ssh/config ${HOME}/.ssh/config

.PHONY: brew
brew:
	cd ${PWD}/brew && brew bundle