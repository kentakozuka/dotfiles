#!/usr/bin/env bash

set -e

# Install asdf
if ! command -v asdf &> /dev/null
then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0
fi

ln -sf ${PWD}/git/.gitconfig ${HOME}/.gitconfig
ln -sf ${PWD}/zsh/.zshrc ${HOME}/.zshrc
mkdir -p ${HOME}/.ssh &&ln -sf ${PWD}/ssh/config ${HOME}/.ssh/config

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	mkdir -p ${HOME}/.config/karabiner && ln -sf ${PWD}/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json

	mkdir -p ${HOME}/Library/KeyBindings
	cp keybinding/DefaultKeybinding.dict ${HOME}/Library/KeyBindings/
fi