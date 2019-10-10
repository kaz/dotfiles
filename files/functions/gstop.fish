function gstop -a NAME
	if [ -z $NAME ]
		set NAME "default"
	end

	gcloud compute instances stop $NAME
end
