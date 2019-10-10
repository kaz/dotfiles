function gcreate
	set NAME $argv[1]
	if [ -z $NAME ]
		set NAME "default"
	end

	set TYPE $argv[2]
	if [ -z $TYPE ]
		set TYPE "1"
	end

	set ZONE $argv[3]
	if [ -z $ZONE ]
		set ZONE "b"
	end

	gcloud compute instances create $NAME --machine-type=n1-standard-$TYPE --zone=asia-northeast1-$ZONE --image-project=arch-linux-gce --image-family=arch --boot-disk-size=30GB --preemptible
end
