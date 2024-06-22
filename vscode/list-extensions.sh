#!/usr/bin/env bash

if ! command -v code &> /dev/null
then
    echo "code could not be found"
    exit
fi

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo ${SCRIPTPATH}
extension_file="${SCRIPTPATH}/extensions"

code --list-extensions > $extension_file