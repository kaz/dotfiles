function gcreate -a NAME TYPE ZONE
	if [ -z $NAME ]
		set NAME "default"
	end
	if [ -z $TYPE ]
		set TYPE "1"
	end
	if [ -z $ZONE ]
		set ZONE "b"
	end

	gcloud compute instances create $NAME --machine-type=n1-standard-$TYPE --zone=asia-northeast1-$ZONE --image-project=arch-linux-gce --image-family=arch --boot-disk-size=30GB --preemptible
end
