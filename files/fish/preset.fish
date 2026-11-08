# disable greeting
set fish_greeting

# modify color theme
set fish_color_command blue

# editor
set -gx EDITOR "nano"

# homebrew
set HOMEBREW_PREFIX "/opt/homebrew"
fish_add_path -g "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"

# ssh
set -gx SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# aqua
if command -q aqua
	fish_add_path -g (aqua root-dir)/bin
	set -gx AQUA_GLOBAL_CONFIG $HOME/.config/aquaproj-aqua/aqua.yaml
end

# docker
if command -q docker
	set -gx DOCKER_BUILDKIT 1
	set -gx COMPOSE_DOCKER_CLI_BUILD 1
end

# go
if command -q go
	set -gx GOPATH "$HOME/.go"
	fish_add_path -g "$GOPATH/bin"
end

# npm
set NPM_BIN_PATH "$HOME/.npm/bin"
if test -d $NPM_BIN_PATH
	fish_add_path -g $NPM_BIN_PATH
end

# rust
set RUST_INCLUDE "$HOME/.cargo/env.fish"
if test -r $RUST_INCLUDE
	source $RUST_INCLUDE
end

# python
set PYTHON_INCLUDE "$HOME/.venv/bin/activate.fish"
if test -r $PYTHON_INCLUDE
	set VIRTUAL_ENV_DISABLE_PROMPT true
	source $PYTHON_INCLUDE
	alias pip="uv pip"
end

# gcloud-cli
set GOOGLE_CLOUD_SDK_BIN_PATH "$HOMEBREW_PREFIX/share/google-cloud-sdk/bin"
if test -d $GOOGLE_CLOUD_SDK_BIN_PATH
	set -gx CLOUDSDK_PYTHON (which python)
	fish_add_path -g $GOOGLE_CLOUD_SDK_BIN_PATH
end

# Android SDK
set ANDROID_HOME "$HOME/Library/Android/sdk"
if test -d $ANDROID_HOME
	set -gx ANDROID_HOME $ANDROID_HOME
	fish_add_path -g "$ANDROID_HOME/platform-tools"
end

# Android Studio embedded JDK
set JAVA_HOME "/Applications/Android Studio.app/Contents/jbr/Contents/Home"
if test -d $JAVA_HOME
	set -gx JAVA_HOME $JAVA_HOME
end
