#!/bin/sh

if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
	HOMEBREW_PREFIX="/opt/homebrew"
else
	HOMEBREW_PREFIX="/usr/local"
fi

BREW_BIN="$HOMEBREW_PREFIX/bin/brew"
PYTHON_BIN="$HOMEBREW_PREFIX/bin/python3"

if [ ! -x $BREW_BIN ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ ! -x $PYTHON_BIN ]; then
	$BREW_BIN install python
fi

if [ ! -r ~/.venv/bin/activate ]; then
	$PYTHON_BIN -m venv ~/.venv
fi

. ~/.venv/bin/activate

if [ ! -x "$(command -v ansible)" ]; then
	pip install ansible
fi

ansible-playbook playbook.yml "$@"
