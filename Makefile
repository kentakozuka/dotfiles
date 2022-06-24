.PHONY: vscode
vscode:
	${PWD}/vscode/list-extensions.sh

.PHONY: brew
brew:
	(cd brew && brew bundle dump --force)