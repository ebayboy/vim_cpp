#!/bin/sh

URL=$1
PATH=$2

# 	git submodule add <url> .vim/bundle/YouCompleteMe
if [ -z "$1" ] || [ -z "$2" ]; then
	echo "git submodule add <url> .vim/bundle/YouCompleteMe"
	exit 1
fi

git submodule add $URL $PATH

