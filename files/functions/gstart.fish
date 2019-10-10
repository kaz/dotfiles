function gstart -a NAME
	if [ -z $NAME ]
		set NAME "default"
	end

	gcloud compute instances start $NAME
end
