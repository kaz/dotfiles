# editor
export EDITOR="nano"

# coloring
alias ls="ls -G"
alias grep="grep --color=auto"

# zsh-completion
if [ -e "/usr/local/share/zsh-completions" ]; then
    fpath=("/usr/local/share/zsh-completions" $fpath)
	autoload -U compinit
	compinit
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
