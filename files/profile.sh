FISH_BIN="{{ homebrew_prefix[ansible_architecture] }}/bin/fish"
if [ -x $FISH_BIN ]; then
	exec $FISH_BIN
fi
