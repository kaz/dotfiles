function gdelete
	set NAME $argv[1]
	if [ -z $NAME ]
		set NAME "default"
	end

	gcloud compute instances delete $NAME
end
