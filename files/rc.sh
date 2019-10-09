# load settings from ~/.zshrc.d
if [ -d ~/.zshrc.d ]; then
	for PROFILE in ~/.zshrc.d/*.sh; do
		if [ -r "$PROFILE" ]; then
			. "$PROFILE"
		fi
	done
fi
