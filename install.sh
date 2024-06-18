#!/usr/bin/env bash

set -e

ln -sf ${HOME}/dotfiles/git/.gitconfig ${HOME}/.gitconfig
ln -sf ${HOME}/dotfiles/zsh/.zshrc ${HOME}/.zshrc
mkdir -p ${HOME}/.ssh &&ln -sf ${HOME}/dotfiles/ssh/config ${HOME}/.ssh/config

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	mkdir -p ${HOME}/.config/karabiner && ln -sf ${PWD}/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json
	mkdir -p ${HOME}/Library/KeyBindings
	cp keybinding/DefaultKeybinding.dict ${HOME}/Library/KeyBindings/
fi