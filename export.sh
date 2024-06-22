#!/usr/bin/env bash

SCRIPTPATH="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)"
source ${SCRIPTPATH}/vscode/list-extensions.sh

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	SCRIPTPATH="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)"
	(cd ${SCRIPTPATH}/brew && brew bundle dump --force)
fi