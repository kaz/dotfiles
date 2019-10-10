complete -f -c gssh -n __fish_is_first_arg -a (echo (glist --format json | __glist_list_names))
