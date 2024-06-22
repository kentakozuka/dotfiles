#!/usr/bin/env bash

set -e

DOTFILES=${HOME}/dotfiles
if [ "${CODESPACES}" = "true" ] ; then
	echo "I'm on Codespaces"
	DOTFILES=/workspaces/.codespaces/.persistedshare/dotfiles
fi

ln -sf ${DOTFILES}/git/.gitconfig ${HOME}/.gitconfig
ln -sf ${DOTFILES}/zsh/.zshrc ${HOME}/.zshrc
mkdir -p ${HOME}/.ssh && ln -sf ${DOTFILES}/ssh/config ${HOME}/.ssh/config

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	mkdir -p ${HOME}/.config/karabiner && ln -sf ${DOTFILES}/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json
	mkdir -p ${HOME}/Library/KeyBindings && ln -sf ${DOTFILES}/keybinding/DefaultKeybinding.dict ${HOME}/Library/KeyBindings/
fi