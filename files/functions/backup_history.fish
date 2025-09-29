function backup_history
	set FISH_DIR "$HOME/.local/share/fish"
	mkdir -p "$FISH_DIR/backup"

	history save
	zstdmt -q -f -o "$FISH_DIR/backup/fish_history.$(hostname).zstd" "$FISH_DIR/fish_history"
end
