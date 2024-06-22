#!/usr/bin/env bash

set -e

SCRIPTPATH="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)"
source ${SCRIPTPATH}/vscode/list-extensions.sh

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	(cd ${SCRIPTPATH}/brew && brew bundle dump --force)
fi