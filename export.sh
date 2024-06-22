#!/usr/bin/env bash

set -e

(cd vscode && source list-extensions.sh)

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	(cd brew && brew bundle dump --force)
fi