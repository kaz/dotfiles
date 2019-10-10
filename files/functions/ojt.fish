function ojt
	python3 -m py_compile solve.py || return
	oj t -c "python3 solve.py"
end
