function backup_history
	history save

	set BACKUP /tmp/fish_history.(date +%s).zstd
	zstdmt -q -f -o "$BACKUP" "$HOME/.local/share/fish/fish_history"

	__backup_history_in_dir "$BACKUP" "$HOME/Library/Mobile Documents/com~apple~CloudDocs/fish_history_backup"

	set GOOGLE_DRIVE_MOUNT_PATH "$HOME/Google Drive/マイドライブ"
	if [ -d "$GOOGLE_DRIVE_MOUNT_PATH" ]
		__backup_history_in_dir "$BACKUP" "$GOOGLE_DRIVE_MOUNT_PATH/archive/fish_history_backup"
	else
		echo "backup_history: Google Drive is not mounted."
	end

	rm "$BACKUP"
end

function __backup_history_in_dir -a BACKUP DIR
	if [ ! -d "$DIR" ]
		mkdir -p "$DIR"
	end

	cp "$BACKUP" "$DIR"
	ls -t "$DIR" | tail -n +1001 | xargs -I {} rm "$DIR/{}"
end
