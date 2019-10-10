function __complete_atcoder_url
	if pbpaste | grep "^https://atcoder.jp/contests/"
		pbpaste
	end
	return 0
end

complete -x -c ojd -n "__fish_is_first_arg" -a "(__complete_atcoder_url)"
complete -x -c ojd -n "not __fish_is_first_arg" -a ""
