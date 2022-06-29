# disable greeting
set fish_greeting

# editor
set -x EDITOR "nano"

# homebrew: add PATH
set HOMEBREW_PREFIX "/opt/homebrew"
set -x PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH

# ssh
set -x SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# docker
if [ -x (command -v docker) ]
	set -x DOCKER_BUILDKIT 1
	set -x COMPOSE_DOCKER_CLI_BUILD 1
end

# golang
if [ -x (command -v go) ]
	set -x GOPATH "$HOME/.go"
	set -x PATH "$GOPATH/bin" $PATH
end

# ruby
set RUBY_PATH "$HOMEBREW_PREFIX/opt/ruby/bin"
if [ -d $RUBY_PATH ]
	set -x PATH $RUBY_PATH $PATH
end

# mysql-client
set MYSQL_CLIENT_PATH "$HOMEBREW_PREFIX/opt/mysql-client/bin"
if [ -d $MYSQL_CLIENT_PATH ]
	set -x PATH $MYSQL_CLIENT_PATH $PATH
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

# gke-gcloud-auth-plugin
if [ -x (command -v gke-gcloud-auth-plugin) ]
	set -x USE_GKE_GCLOUD_AUTH_PLUGIN True
end

# load machine specific configuration
set LOCAL_INCLUDE "$HOME/.config/fish/local.fish"
if [ -r $LOCAL_INCLUDE ]
	source $LOCAL_INCLUDE
end

# apply PATH to lanchctl
sudo launchctl config user path (echo $PATH | tr " " ":") > /dev/null &
