#!/usr/bin/env bash

set -e

(cd vscode && source list-extensions.sh)
(cd brew && brew bundle dump --force)