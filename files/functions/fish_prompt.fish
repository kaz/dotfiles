function fish_prompt
    echo -n (set_color FFFFFF)(set_color -b 005FFF) (prompt_hostname) (set_color -b 005FD7) $USER (set_color -b 005FAF) (prompt_pwd) (set_color normal)(set_color -o 005F87) \$ (set_color normal)
end
