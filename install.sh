# if [ $SHELL != "/bin/zsh" ]; then
#     echo "use zsh as the default shell"
#     exit 1
# fi

if [ "$REMOTE_CONTAINERS" = true ]; then
    echo "I'm in a remote container"
else
    echo "I'm NOT in a remote container"
fi

touch ~/hello
# ln -sf ${PWD}/tmux/.tmux.conf ${HOME}/.tmux.conf
# ln -sf ${PWD}/tmux/status.sh ${HOME}/.tmux/status.sh
# ln -sf ${PWD}/git/.gitconfig ${HOME}/.gitconfig
# ln -sf ${PWD}/ssh/config ${HOME}/.ssh/config
ln -sf ${PWD}/zsh/.zshrc ${HOME}/.zshrc

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	ln -sf ${PWD}/config/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json
fi