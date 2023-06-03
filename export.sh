#!/usr/bin/env bash

set -e

echo "I'm on $(uname)"
if [ "$(uname)" = "Darwin" ] ; then
	(cd brew && brew bundle dump --force)
fi