function gcreate -a NAME TYPE ZONE
	if [ -z $NAME ]
		set NAME "default"
	end
	if [ -z $TYPE ]
		set TYPE "e2-medium"
	end
	if [ -z $ZONE ]
		set ZONE "asia-northeast1-b"
	end

	gcloud compute instances create $NAME --machine-type=$TYPE --zone=$ZONE --image-project=arch-linux-gce --image-family=arch --boot-disk-size=30GB --preemptible
end
