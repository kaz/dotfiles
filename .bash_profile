# PS1
if [ "$(uname)" == 'Darwin' ]; then
	export PS1='\[\e[38;5;231m\e[48;5;27m\] \h \[\e[48;5;26m\] \u \[\e[48;5;25m\] \W \[\e[0m\e[38;5;24m\] \$ \[\e[0m\]'
elif [ $EUID = 0 ]; then
	export PS1='\[\e[38;5;231m\e[48;5;199m\] \h \[\e[48;5;198m\] \u \[\e[48;5;197m\] \W \[\e[0m\e[38;5;196m\] \$ \[\e[0m\]'
else
	export PS1='\[\e[38;5;231m\e[48;5;37m\] \h \[\e[48;5;36m\] \u \[\e[48;5;35m\] \W \[\e[0m\e[38;5;34m\] \$ \[\e[0m\]'
fi

# editor
export EDITOR=nano

# coloring
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# bash-completion
if [ -r "/usr/local/etc/profile.d/bash_completion.sh" ]; then
	. "/usr/local/etc/profile.d/bash_completion.sh"
fi

# ruby
if [ -x "/usr/local/opt/ruby/bin" ]; then
	export PATH="/usr/local/opt/ruby/bin:$PATH"
fi

# golang
if [ -x "$(command -v go)" ]; then
	export GO111MODULE=on
	export GOPATH=$HOME/go
	export GOPATH_TOOLS=$HOME/.go_tools
	export PATH=$GOPATH/bin:$GOPATH_TOOLS/bin:$PATH
fi

# for macOS
if [ "$(uname)" == 'Darwin' ]; then
	# coloring
	alias ls='ls -G'

	# homebrew
	export PATH=/usr/local/sbin:$PATH

	# switch python for node-gyp
	alias node-gyp='node-gyp --python $(which python2.7)'
fi

#################
### FUNCTIONS ###
#################
dbup () {
	CurDir=`pwd`
	cd ~/.database/$1
	docker-compose up -d
	cd $CurDir
}
devcontainer() {
	ln -sf ~/.devcontainer .
}

###############
### ATCODER ###
###############
ojd () {
	DIR="$HOME/Desktop/oj/$(echo $1 | awk -F / '{print $7}')"
	mkdir -p $DIR
	cd $DIR
	oj d $1 || return
	code -a solve.py
}
ojt () {
	python3 -m py_compile solve.py || return
	oj t -c "python3 solve.py"
}
ojs () {
	oj s -w 0 --no-guess -l python3 solve.py
}

# load .bashrc (for machine-specific configuration)
if [ -r "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi
