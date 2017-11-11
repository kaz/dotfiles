# PS1 for remote server
if [ $EUID = 0 ]; then
	export PS1='\[\e[38;5;231m\e[48;5;199m\] \h \[\e[48;5;198m\] \u \[\e[48;5;197m\] \W \[\e[0m\e[38;5;196m\] \$ \[\e[0m\]'
else
	export PS1='\[\e[38;5;231m\e[48;5;37m\] \h \[\e[48;5;36m\] \u \[\e[48;5;35m\] \W \[\e[0m\e[38;5;34m\] \$ \[\e[0m\]'
fi

# PS1 for local
export PS1='\[\e[38;5;231m\e[48;5;27m\] \h \[\e[48;5;26m\] \u \[\e[48;5;25m\] \W \[\e[0m\e[38;5;24m\] \$ \[\e[0m\]'

# coloring
if [ "$(uname)" == 'Darwin' ]; then
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi
alias grep='grep --color=auto'

# nodenv
which nodenv > /dev/null
if [ $? != 0 ]; then
	eval "$(nodenv init -)"
fi

# gopath
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# editor
export EDITOR=nano



#################
### FUNCTIONS ###
#################
dbup () {
	CurDir=`pwd`
	cd ~/.database/$1
	docker-compose up -d
	cd $CurDir
}
