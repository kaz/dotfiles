function ojd
	set PROBLEM_URL $argv[1]
	set PROBLEM_DIR "$HOME/Desktop/oj/"(echo $PROBLEM_URL | awk -F / '{print $7}')

	mkdir -p $PROBLEM_DIR
	cd $PROBLEM_DIR

	oj d $PROBLEM_URL || return
	code -a solve.py
end
