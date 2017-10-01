# PS1 for remote server
if [ $EUID = 0 ]; then
	export PS1='\[\e[38;5;231m\e[48;5;199m\] \h \[\e[48;5;198m\] \u \[\e[48;5;197m\] \W \[\e[0m\e[38;5;196m\] \$ \[\e[0m\]'
else
	export PS1='\[\e[38;5;231m\e[48;5;37m\] \h \[\e[48;5;36m\] \u \[\e[48;5;35m\] \W \[\e[0m\e[38;5;34m\] \$ \[\e[0m\]'
fi

# PS1 for local
export PS1='\[\e[38;5;231m\e[48;5;27m\] \h \[\e[48;5;26m\] \u \[\e[48;5;25m\] \W \[\e[0m\e[38;5;24m\] \$ \[\e[0m\]'

# coloring
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# editor
export EDITOR=nano

# gopath
export GOPATH=~/Desktop/go
export PATH=$PATH:$GOPATH/bin
