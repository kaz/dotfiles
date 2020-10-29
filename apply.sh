#!/bin/sh

if [ ! -x /usr/local/bin/brew ]; then
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [ ! -x /usr/local/bin/python3 ]; then
	brew install python
fi

if [ ! -r ~/.venv/bin/activate ]; then
	/usr/local/bin/python3 -m venv ~/.venv
fi

. ~/.venv/bin/activate

if [ ! -x "$(command -v ansible)" ]; then
	pip install ansible
fi

ansible-playbook playbook.yml "$@"
