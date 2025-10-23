#!/usr/bin/env bash

if [ "${CODESPACES}" = "true" ] ; then
	echo "I'm on Codespaces"
fi

SCRIPTPATH="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)"

ln -sf ${SCRIPTPATH}/git/.gitconfig ${HOME}/.gitconfig
ln -sf ${SCRIPTPATH}/git/.gitignore ${HOME}/.gitignore
ln -sf ${SCRIPTPATH}/zsh/.zshrc ${HOME}/.zshrc
ln -sf ${SCRIPTPATH}/asdf/.asdfrc ${HOME}/.asdfrc
ln -sf ${SCRIPTPATH}/vim/.vimrc ${HOME}/.vimrc
mkdir -p ${HOME}/.ssh && ln -sf ${SCRIPTPATH}/ssh/config ${HOME}/.ssh/config
mkdir -p ${HOME}/.aws && ln -sf ${SCRIPTPATH}/aws/amazonq ${HOME}/.aws/amazonq
mkdir -p ${HOME}/.hammerspoon && ln -sf ${SCRIPTPATH}/hammerspoon/init.lua ${HOME}/.hammerspoon/init.lua

if [ "$(uname)" = "Darwin" ] ; then
	mkdir -p ${HOME}/.config/karabiner && ln -sf ${SCRIPTPATH}/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json
fi

source ${SCRIPTPATH}/vscode/install-extensions.sh