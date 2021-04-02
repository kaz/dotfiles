if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
	HOMEBREW_PREFIX="/opt/homebrew"
else
	HOMEBREW_PREFIX="/usr/local"
fi

FISH_BIN="$HOMEBREW_PREFIX/bin/fish"
if [ -x $FISH_BIN ]; then
	exec $FISH_BIN
fi
