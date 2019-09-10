gceup () {
	gcloud compute instances create $1 --image-project=arch-linux-gce --image-family=arch --machine-type=n1-standard-1 --boot-disk-size=25GB --preemptible
}

gssh () {
	fetch_list () {
		gcloud compute instances list --format json
	}
	get_stat () {
		jq -r "[.[] | {key: .name, value: .status}] | from_entries.\"$1\""
	}
	get_addr () {
		jq -r "[.[] | {key: .name, value: .networkInterfaces[0].accessConfigs[0].natIP}] | from_entries.\"$1\""
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
	sleep 5

	connect $(fetch_list | get_addr $NAME) ${@:2}
}
