function gssh
	function fetch_list
		gcloud compute instances list --format json
	end
	function get_stat
		jq -r "[.[] | {key: .name, value: .status}] | from_entries.\"$argv[1]\""
	end
	function get_addr
		jq -r "[.[] | {key: .name, value: .networkInterfaces[0].accessConfigs[0].natIP}] | from_entries.\"$argv[1]\""
	end
	function connect
		ssh $argv
	end

	set NAME $argv[1]
	if [ -z $NAME ]
		set NAME "default"
	end

	set LIST (fetch_list)
	set STATUS (echo $LIST | get_stat $NAME)
	if [ $STATUS = "null" ]
		echo "No such instance: $NAME"
		return 1
	else if [ $STATUS = "RUNNING" ]
		connect (echo $LIST | get_addr $NAME) $argv[2..-1]
		return 0
	end

	gstart $NAME
	connect (fetch_list | get_addr $NAME) $argv[2..-1]
end
