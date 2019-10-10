function gstart
	set NAME $argv[1]
	if [ -z $NAME ]
		set NAME "default"
	end

	gcloud compute instances start $NAME
end
