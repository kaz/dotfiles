# PROMPT (red)
PROMPT='%F{255}%K{199} %m %K{198} %n %K{197} %~ %k%F{196} $ %f'
# PROMPT (green)
PROMPT='%F{255}%K{037} %m %K{036} %n %K{035} %~ %k%F{034} $ %f'
# PROMPT (blue)
PROMPT='%F{255}%K{027} %m %K{026} %n %K{025} %~ %k%F{024} $ %f'

# editor
export EDITOR="nano"

# coloring
alias ls="ls -G"
alias grep="grep --color=auto"

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
