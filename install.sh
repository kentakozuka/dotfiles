#!/usr/bin/env bash

set -e

SCRIPTPATH="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)"

if [ "${CODESPACES}" = "true" ] ; then
	echo "I'm on Codespaces"
fi

ln -sf ${SCRIPTPATH}/git/.gitconfig ${HOME}/.gitconfig
ln -sf ${SCRIPTPATH}/zsh/.zshrc ${HOME}/.zshrc
mkdir -p ${HOME}/.ssh && ln -sf ${SCRIPTPATH}/ssh/config ${HOME}/.ssh/config
source ${SCRIPTPATH}/vscode/install-extensions.sh

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	mkdir -p ${HOME}/.config/karabiner && ln -sf ${SCRIPTPATH}/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json
	mkdir -p ${HOME}/Library/KeyBindings && ln -sf ${SCRIPTPATH}/keybinding/DefaultKeybinding.dict ${HOME}/Library/KeyBindings/
fi