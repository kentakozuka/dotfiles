#!/usr/bin/env bash

set -e

ln -sf ${PWD}/git/.gitconfig ${HOME}/.gitconfig
ln -sf ${PWD}/zsh/.zshrc ${HOME}/.zshrc
mkdir -p ${HOME}/.ssh &&ln -sf ${PWD}/ssh/config ${HOME}/.ssh/config
ln -sf ${PWD}/tmux/.tmux.conf ${HOME}/.tmux.conf
mkdir -p ${HOME}/.tmux && ln -sf ${PWD}/tmux/status.sh ${HOME}/.tmux/status.sh

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	mkdir -p ${HOME}/.config/karabiner && ln -sf ${PWD}/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json
    mkdir -p ${HOME}/Library/Application\ Support/Code/User && ln -sf ${PWD}/vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json
    mkdir -p ${HOME}/Library/Application\ Support/Code/User && ln -sf ${PWD}/vscode/keybindings.json ${HOME}/Library/Application\ Support/Code/User/keybindings.json
    (cd vscode && source install-extensions.sh)
fi