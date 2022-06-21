.PHONY: list-extensions
list-extensions:
	${PWD}/vscode/list-extensions.sh

.PHONY: vscode
vscode:
	source ${PWD}/vscode/install_extensions.sh
	ln -sf ${PWD}/vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json

.PHONY: brew
brew:
	cd ${PWD}/brew && brew bundle