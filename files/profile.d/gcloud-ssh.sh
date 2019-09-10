gssh () {
	fetch_list () {
		gcloud compute instances list --format json
	}
	get_stat () {
		jq -r "[.[]  | {key: .name, value: .status}] | from_entries.\"$1\""
	}
	get_addr () {
		jq -r "[.[]  | {key: .name, value: .networkInterfaces[0].accessConfigs[0].natIP}] | from_entries.\"$1\""
	}
	connect () {
		ssh $1
	}

	NAME=$1

	if [ -z $NAME ]; then
		echo "Usage: ${FUNCNAME[0]} [instance-name]"
		return -1
	fi

	LIST=$(fetch_list)
	STATUS=$(echo $LIST | get_stat $NAME)

	if [ $STATUS == "null" ]; then
		echo "No such instance: $NAME"
		return -1
	elif [ $STATUS == "RUNNING" ]; then
		connect $(echo $LIST | get_addr $NAME) ${@:2}
		return 0
	fi

	gcloud compute instances start $NAME
	ADDR=$(fetch_list | get_addr $NAME)
	nc -z $ADDR 22
	connect $ADDR ${@:2}
}
