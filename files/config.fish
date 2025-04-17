# disable greeting
set fish_greeting

# modify color theme
set fish_color_command blue

# editor
set -gx EDITOR "nano"

# homebrew: add PATH
set HOMEBREW_PREFIX "/opt/homebrew"
fish_add_path -g "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"

# ssh
set -gx SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# docker
if [ -x (command -v docker) ]
	set -gx DOCKER_BUILDKIT 1
	set -gx COMPOSE_DOCKER_CLI_BUILD 1
end

# go
if [ -x (command -v go) ]
	set -gx GOPATH "$HOME/.go"
	fish_add_path -g "$GOPATH/bin"
end

# ruby
set RUBY_PATH "$HOMEBREW_PREFIX/opt/ruby/bin"
if [ -d $RUBY_PATH ]
	fish_add_path -g $RUBY_PATH
end

# npm
set NPM_PATH "$HOME/.npm/bin"
if [ -d $NPM_PATH ]
	fish_add_path -g $NPM_PATH
end

alias npx="pnpm dlx"
alias pnpx="pnpm dlx"

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
	set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True
end

# Android SDK
set ANDROID_HOME "$HOME/Library/Android/sdk"
if [ -d $ANDROID_HOME ]
	set -gx ANDROID_HOME $ANDROID_HOME
	fish_add_path -g "$ANDROID_HOME/platform-tools"
end

# Android Studio embedded JDK
set JAVA_HOME "/Applications/Android Studio.app/Contents/jbr/Contents/Home"
if [ -d $JAVA_HOME ]
	set -gx JAVA_HOME $JAVA_HOME
end

# aqua
if [ -x (command -v aqua) ]
	fish_add_path -g (aqua root-dir)/bin
	set -gx AQUA_GLOBAL_CONFIG $HOME/.config/aquaproj-aqua/aqua.yaml
end

# load machine specific configuration
set LOCAL_INCLUDE "$HOME/.config/fish/local.fish"
if [ -r $LOCAL_INCLUDE ]
	source $LOCAL_INCLUDE
end

# backup history after each command
function __postexec_backup_history --on-event fish_postexec
	backup_history &
end
