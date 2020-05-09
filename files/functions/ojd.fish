function ojd
	set PROBLEM_URL $argv[1]
	set PROBLEM_DIR "$HOME/Desktop/oj/"(echo $PROBLEM_URL | awk -F / '{print $7}')

	if [ ! -d $PROBLEM_DIR ]
		mkdir -p $PROBLEM_DIR
		cd $PROBLEM_DIR
		oj d $PROBLEM_URL || return
	end

	code -r $PROBLEM_DIR

	switch OJ_LANG
	case python
		__ojd_python3
	case '*'
		__ojd_rust
	end
end

function __ojd_python3
	code -g ./solve.py
end

function __ojd_rust
	if [ ! -f ./src/main.rs ]
		cargo init --vcs none
	end
	code -g ./src/main.rs
end
