ojd () {
	DIR="$HOME/Desktop/oj/$(echo $1 | awk -F / '{print $7}')"
	mkdir -p $DIR
	cd $DIR
	oj d $1 || return
	code -a solve.py
}
ojt () {
	python3 -m py_compile solve.py || return
	oj t -c "python3 solve.py"
}
ojs () {
	oj s -w 0 --no-guess -l python3 solve.py
}
