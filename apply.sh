#!/bin/bash

if [ ! -x "$(command -v brew)" ]; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ ! -x "$(command -v python3)" ]; then
	brew install python3
fi

if [ ! -d ~/.venv ]; then
	python3 -m venv ~/.venv
fi

. ~/.venv/bin/activate

if [ ! -x "$(command -v ansible)" ]; then
	pip install ansible<2.8.0
fi

ansible-playbook playbook.yml --diff
