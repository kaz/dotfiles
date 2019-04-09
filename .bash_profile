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

# ssh (rmate)
alias sshr='ssh -R 52698:localhost:52698'

# nodenv
which nodenv > /dev/null
if [ $? == 0 ]; then
	eval "$(nodenv init -)"
fi

# gopath
which go > /dev/null
if [ $? == 0 ]; then
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
vmup () {
	ln -s ~/dotfiles/Vagrantfile
	vagrant up
}
