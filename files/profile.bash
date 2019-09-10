# PS1
if [ "$(uname)" == "Darwin" ]; then
	export PS1="\[\e[38;5;231m\e[48;5;27m\] \h \[\e[48;5;26m\] \u \[\e[48;5;25m\] \W \[\e[0m\e[38;5;24m\] \$ \[\e[0m\]"
elif [ $EUID == 0 ]; then
	export PS1="\[\e[38;5;231m\e[48;5;199m\] \h \[\e[48;5;198m\] \u \[\e[48;5;197m\] \W \[\e[0m\e[38;5;196m\] \$ \[\e[0m\]"
else
	export PS1="\[\e[38;5;231m\e[48;5;37m\] \h \[\e[48;5;36m\] \u \[\e[48;5;35m\] \W \[\e[0m\e[38;5;34m\] \$ \[\e[0m\]"
fi

# editor
export EDITOR="nano"

# coloring
alias ls="ls --color=auto"
alias grep="grep --color=auto"
if [ "$(uname)" == "Darwin" ]; then
	alias ls="ls -G"
fi

# bash-completion
if [ -r "/usr/local/etc/profile.d/bash_completion.sh" ]; then
	. "/usr/local/etc/profile.d/bash_completion.sh"
fi

# ruby
if [ -x "/usr/local/opt/ruby/bin" ]; then
	export PATH="/usr/local/opt/ruby/bin:$PATH"
fi

# python
if [ -r "$HOME/.venv/bin/activate" ]; then
	VIRTUAL_ENV_DISABLE_PROMPT=true
	. "$HOME/.venv/bin/activate"
fi

# golang
if [ -x "$(command -v go)" ]; then
	export GOPATH=$HOME/.go
	export PATH=$GOPATH/bin:$PATH
fi

# node-gyp
if [ -x "$(command -v node-gyp)" ]; then
	alias node-gyp="node-gyp --python $(which python2.7)"
fi

# brew
if [ -x "$(command -v brew)" ]; then
	export PATH="/usr/local/sbin:$PATH"
	alias brew="PATH=${PATH/$HOME\/.venv\/bin:/} brew"
fi

# Load profiles from ~/.profile.d
if [ -d ~/.profile.d ]; then
	for PROFILE in ~/.profile.d/*.sh; do
		if [ -r "$PROFILE" ]; then
			. "$PROFILE"
		fi
	done
fi
