function ojt
	switch OJ_LANG
	case python
		__ojt_python3
	case '*'
		__ojt_rust
	end
end

function __ojt_python3
	python3 -m py_compile ./solve.py || return
	oj t -c "python3 ./solve.py"
end

function __ojt_rust
	set -x RUST_BACKTRACE 1
	cargo build || return
	oj t -c "cargo run"
end
