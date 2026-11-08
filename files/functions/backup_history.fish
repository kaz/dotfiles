function backup_history
	set FISH_DIR "$HOME/.local/share/fish"
	mkdir -p "$FISH_DIR/backup"

	history save
	cp -f "$FISH_DIR/fish_history" "$FISH_DIR/backup/fish_history.$(hostname)"
end
