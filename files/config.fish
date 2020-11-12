# disable greeting
set fish_greeting

# editor
set -x EDITOR "nano"

# python
if [ -r "$HOME/.venv/bin/activate.fish" ]
	set VIRTUAL_ENV_DISABLE_PROMPT true
	source "$HOME/.venv/bin/activate.fish"
end

# ruby
if [ -d "/usr/local/opt/ruby/bin" ]
	set -x PATH "/usr/local/opt/ruby/bin" $PATH
end

# rust
if [ -d "$HOME/.cargo/bin" ]
	set -x PATH "$HOME/.cargo/bin" $PATH
end

# npm
if [ -d "$HOME/.npm/bin" ]
	set -x PATH "$HOME/.npm/bin" $PATH
end

# golang
if [ -x (command -v go) ]
	set -x GOPATH "$HOME/.go"
	set -x PATH "$GOPATH/bin" $PATH
end

# homebrew
if [ -x (command -v brew) ]
	set -x PATH "/usr/local/sbin" $PATH
end

# ssh
if [ -x (command -v gpgconf) ]
	set SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
	gpgconf --launch gpg-agent
end

# docker
if [ -x (command -v docker) ]
	set -x DOCKER_BUILDKIT 1
end

# load machine specific configuration
if [ -r "$HOME/.config/fish/local.fish" ]
	source "$HOME/.config/fish/local.fish"
end
