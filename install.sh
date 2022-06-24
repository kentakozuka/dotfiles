if [ "$REMOTE_CONTAINERS" = true ]; then
    echo "I'm in a remote container"
else
    echo "I'm NOT in a remote container"
fi

ln -sf ${PWD}/git/.gitconfig ${HOME}/.gitconfig
ln -sf ${PWD}/zsh/.zshrc ${HOME}/.zshrc
mkdir -p ${HOME}/.ssh &&ln -sf ${PWD}/ssh/config ${HOME}/.ssh/config

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	mkdir -p ${HOME}/.config/karabiner && ln -sf ${PWD}/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json
    ln -sf ${PWD}/tmux/.tmux.conf ${HOME}/.tmux.conf
    mkdir -p ${HOME}/.tmux && ln -sf ${PWD}/tmux/status.sh ${HOME}/.tmux/status.sh
    ln -sf ${PWD}/vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json
    (cd vscode && source install-extensions.sh)
fi