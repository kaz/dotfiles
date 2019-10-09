grun () {
	NAME=$1
	if [ -z $NAME ]; then
		NAME="default"
	fi

	TYPE=$2
	if [ -z $TYPE ]; then
		TYPE="1"
	fi

	ZONE=$3
	if [ -z $ZONE ]; then
		ZONE="b"
	fi

	gcloud compute instances create $NAME --machine-type=n1-standard-$TYPE --zone=asia-northeast1-$ZONE --image-project=arch-linux-gce --image-family=arch --boot-disk-size=30GB --preemptible
}

gkill () {
	NAME=$1
	if [ -z $NAME ]; then
		NAME="default"
	fi

	gcloud compute instances stop $NAME
}

gdel () {
	NAME=$1
	if [ -z $NAME ]; then
		NAME="default"
	fi

	gcloud compute instances delete $NAME
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
