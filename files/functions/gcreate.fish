function gcreate -a NAME TYPE ZONE SIZE
	if [ -z $NAME ]
		set NAME "default"
	end
	if [ -z $TYPE ]
		set TYPE "e2-micro"
	end
	if [ -z $ZONE ]
		set ZONE "asia-northeast1-b"
	end
	if [ -z $ZONE ]
		set SIZE "10GB"
	end

	gcloud compute instances create $NAME --machine-type=$TYPE --zone=$ZONE --image-project=arch-linux-gce --image-family=arch --boot-disk-size=$SIZE --preemptible
end
