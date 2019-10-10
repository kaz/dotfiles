function gdelete -a NAME
	if [ -z $NAME ]
		set NAME "default"
	end

	gcloud compute instances delete $NAME
end
