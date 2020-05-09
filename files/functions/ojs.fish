function ojs
	switch OJ_LANG
	case python
		__ojs_python3
	case '*'
		__ojs_rust
	end
end

function __ojs_python3
	oj s -w 0 --no-guess -l python3 ./solve.py
end

function __ojs_rust
	ln -s ./src/main.rs ./main.rs
	oj s -w 0 --no-guess -l rust ./main.rs
	rm main.rs
end
