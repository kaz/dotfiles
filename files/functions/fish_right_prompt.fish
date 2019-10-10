function fish_right_prompt
	set last_status $status
	if test $last_status -ne 0
		echo -n (set_color -o $fish_color_error) [$last_status] (set_color normal)
	end
end
