# disable greeting
set fish_greeting

# editor
set -x EDITOR "nano"

# homebrew: add PATH
set HOMEBREW_PREFIX "/opt/homebrew"
fish_add_path "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"

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
	fish_add_path "$GOPATH/bin"
end

# ruby
set RUBY_PATH "$HOMEBREW_PREFIX/opt/ruby/bin"
if [ -d $RUBY_PATH ]
	fish_add_path $RUBY_PATH
end

# mysql-client
set MYSQL_CLIENT_PATH "$HOMEBREW_PREFIX/opt/mysql-client/bin"
if [ -d $MYSQL_CLIENT_PATH ]
	fish_add_path $MYSQL_CLIENT_PATH
end

# libpq
set LIBPQ_PATH "$HOMEBREW_PREFIX/opt/libpq/bin"
if [ -d $LIBPQ_PATH ]
	fish_add_path $LIBPQ_PATH
end

# npm
set NPM_PATH "$HOME/.npm/bin"
if [ -d $NPM_PATH ]
	fish_add_path $NPM_PATH
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

# Android SDK
set ANDROID_HOME "$HOME/Library/Android/sdk"
if [ -d $ANDROID_HOME ]
	set -x ANDROID_HOME $ANDROID_HOME
	fish_add_path "$ANDROID_HOME/platform-tools"
end

# Android Studio embedded JDK
set JAVA_HOME "/Applications/Android Studio.app/Contents/jbr/Contents/Home"
if [ -d $JAVA_HOME ]
	set -x JAVA_HOME $JAVA_HOME
end

# load machine specific configuration
set LOCAL_INCLUDE "$HOME/.config/fish/local.fish"
if [ -r $LOCAL_INCLUDE ]
	source $LOCAL_INCLUDE
end

# apply PATH to lanchctl
sudo launchctl config user path (echo $PATH | tr " " ":") > /dev/null &

# backup history after each command
function __postexec_backup_history --on-event fish_postexec
	backup_history &
end
