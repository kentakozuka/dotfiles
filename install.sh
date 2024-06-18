#!/usr/bin/env bash

set -e

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	ln -sf ${PWD}/git/.gitconfig ${HOME}/.gitconfig
	ln -sf ${PWD}/zsh/.zshrc ${HOME}/.zshrc
	mkdir -p ${HOME}/.ssh &&ln -sf ${PWD}/ssh/config ${HOME}/.ssh/config
	mkdir -p ${HOME}/.config/karabiner && ln -sf ${PWD}/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json

	mkdir -p ${HOME}/Library/KeyBindings
	cp keybinding/DefaultKeybinding.dict ${HOME}/Library/KeyBindings/
else
	ln -sf ${HOME}/dotfiles/git/.gitconfig ${HOME}/.gitconfig
	ln -sf ${HOME}/dotfiles/zsh/.zshrc ${HOME}/.zshrc
	# mkdir -p ${HOME}/.ssh &&ln -sf ${HOME}/dotfiles/ssh/config ${HOME}/.ssh/config
fi