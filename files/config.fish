# disable greeting
set fish_greeting

# editor
set -x EDITOR "nano"

# ruby
if [ -x "/usr/local/opt/ruby/bin" ]
	set -x PATH "/usr/local/opt/ruby/bin" $PATH
end

# golang
if [ -x (command -v go) ]
	set -x GOPATH "$HOME/.go"
	set -x PATH "$GOPATH/bin" $PATH
end

# brew (do not change order)
if [ -x (command -v brew) ]
	set -x PATH "/usr/local/sbin" $PATH
	set SAFE_PATH $PATH
	function brew
		set SAVED_PATH $PATH
		set PATH $SAFE_PATH
		command brew $argv
		set PATH $SAVED_PATH
	end
end

# python (do not change order)
if [ -r "$HOME/.venv/bin/activate" ]
	set VIRTUAL_ENV_DISABLE_PROMPT true
	source "$HOME/.venv/bin/activate.fish"
end
