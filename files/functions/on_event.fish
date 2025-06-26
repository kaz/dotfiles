function __postexec_backup_history --on-event fish_postexec
	backup_history &
end
