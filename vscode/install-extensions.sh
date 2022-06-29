#!/usr/bin/env bash

if ! command -v code &> /dev/null
then
    echo "code could not be found"
    exit
fi

extension_file="$(pwd)/extensions"

cat $extension_file | while read line
do
  code --install-extension $line
done
