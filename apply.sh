#!/bin/sh

if [ ! -x /usr/local/bin/brew ]; then
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [ ! -x /usr/local/bin/python3 ]; then
	brew install python
	brew link --force python
fi

if [ ! -d ~/.venv ]; then
	python3 -m venv ~/.venv
fi

. ~/.venv/bin/activate

if [ ! -x "$(command -v ansible)" ]; then
	pip install ansible
fi

ansible-playbook playbook.yml "$@"
