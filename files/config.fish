# disable greeting
set fish_greeting

# editor
set -x EDITOR "nano"

# homebrew: determine prefix
if [ (/usr/bin/uname -m) = "arm64" ]
	set HOMEBREW_PREFIX "/opt/homebrew"
else
	set HOMEBREW_PREFIX "/usr/local"
end

# homebrew: add PATH
set -x PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH

# docker
if [ -x (command -v docker) ]
	set -x DOCKER_BUILDKIT 1
	set -x COMPOSE_DOCKER_CLI_BUILD 1
end

# ssh
if [ -x (command -v gpgconf) ]
	set SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
	gpgconf --launch gpg-agent
end

# golang
if [ -x (command -v go) ]
	set -x GO111MODULE on
	set -x GOPATH "$HOME/.go"
	set -x PATH "$GOPATH/bin" $PATH
end

# ruby
set RUBY_PATH "$HOMEBREW_PREFIX/opt/ruby/bin"
if [ -d $RUBY_PATH ]
	set -x PATH $RUBY_PATH $PATH
end

# cargo
set CARGO_PATH "$HOME/.cargo/bin"
if [ -d $CARGO_PATH ]
	set -x PATH $CARGO_PATH $PATH
end

# npm
set NPM_PATH "$HOME/.npm/bin"
if [ -d $NPM_PATH ]
	set -x PATH $NPM_PATH $PATH
end

# python
set PYTHON_INCLUDE "$HOME/.venv/bin/activate.fish"
if [ -r $PYTHON_INCLUDE ]
	set VIRTUAL_ENV_DISABLE_PROMPT true
	source $PYTHON_INCLUDE
end

# gcloud
set GCLOUD_INCLUDE "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
if [ -r $GCLOUD_INCLUDE ]
	source $GCLOUD_INCLUDE
end

# load machine specific configuration
set LOCAL_INCLUDE "$HOME/.config/fish/local.fish"
if [ -r $LOCAL_INCLUDE ]
	source $LOCAL_INCLUDE
end
