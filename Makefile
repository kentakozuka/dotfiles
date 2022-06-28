.PHONY: vscode
vscode:
	cd vscode; source install-extensions.sh
	ln -sf ${PWD}/vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json

.PHONY: brew
brew:
	cd brew; brew bundle dump --force