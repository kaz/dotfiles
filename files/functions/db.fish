function db -a DB
	set DIR "$HOME/.database/$DB"
	if [ ! -d $DIR ]
		echo "No such database: $DB"
		return 1
	end

	pushd $DIR
	docker compose $argv[2..-1]
	popd
end
