complete -x -c dbup -n "__fish_is_first_arg" -a "(ls ~/.database)"
complete -x -c dbup -n "not __fish_is_first_arg" -a ""
