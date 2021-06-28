function fish_prompt
	if [ $status = 0 ]
		echo -n (set_color FFFFFF)(set_color -b 005FFF) (prompt_pwd) (set_color normal)(set_color -o 005FD7) \$ (set_color normal)
	else
		echo -n (set_color FFFFFF)(set_color -b FF5F00) (prompt_pwd) (set_color normal)(set_color -o D75F00) \$ (set_color normal)
	end
end
