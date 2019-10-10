function gssh -a NAME
	function connect
		ssh $argv
	end

	if [ -z $NAME ]
		set NAME "default"
	end

	set LIST (glist --format json)
	set STATUS (echo $LIST | __glist_get_status $NAME)
	if [ $STATUS = "null" ]
		echo "No such instance: $NAME"
		return 1
	else if [ $STATUS = "RUNNING" ]
		connect (echo $LIST | __glist_get_address $NAME) $argv[2..-1]
		return 0
	end

	gstart $NAME
	connect (glist --format json | __glist_get_address $NAME) $argv[2..-1]
end
