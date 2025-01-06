function fish_prompt
	if [ $status = 0 ]
		echo -n (set_color -b 06F)(set_color FFF) (prompt_pwd) (set_color -b 00F)(set_color 06F)\uE0B0 (set_color FFF)\$ (set_color -b normal)(set_color 00F)\uE0B0 (set_color normal)
	else
		echo -n (set_color -b F60)(set_color FFF) (prompt_pwd) (set_color -b F00)(set_color F60)\uE0B0 (set_color FFF)\$ (set_color -b normal)(set_color F00)\uE0B0 (set_color normal)
	end
end
