function glist
	gcloud compute instances list $argv
end

function __glist_list_names
	jq -r ".[] | .name"
end

function __glist_get_status -a NAME
	jq -r "[.[] | {key: .name, value: .status}] | from_entries.\"$NAME\""
end

function __glist_get_address -a NAME
	jq -r "[.[] | {key: .name, value: .networkInterfaces[0].accessConfigs[0].natIP}] | from_entries.\"$NAME\""
end
