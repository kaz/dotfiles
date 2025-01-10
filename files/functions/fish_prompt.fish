function fish_prompt
	set PROMPT_PWD (prompt_pwd)
	set PROMPT_PWD_L (string sub -l 1 $PROMPT_PWD)
	set PROMPT_PWD_R (string replace -a "/" (printf " \uE0B1 ") (string sub -s 2 $PROMPT_PWD))
	set PROMPT_PWD (string join "" $PROMPT_PWD_L $PROMPT_PWD_R)
	echo -n (set_color -b 6C5793)(set_color FFF) $PROMPT_PWD (set_color -b 4B3D66)(set_color 6C5793)\uE0B0 (set_color FFF)\$ (set_color -b normal)(set_color 4B3D66)\uE0B0 (set_color normal)
end

function fish_right_prompt
	set VCS_PROMPT (fish_vcs_prompt)
	if [ -n "$VCS_PROMPT" ]
		echo -n " "(set_color C2B7D5)\uE0B2(set_color -b C2B7D5)(set_color 000)$VCS_PROMPT (set_color -b normal)(set_color normal)
	end
end
