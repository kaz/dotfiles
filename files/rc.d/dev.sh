dbup () {
	CUR=`pwd`
	cd ~/.database/$1
	docker-compose up -d
	cd $CUR
}

devcontainer () {
	ln -sf ~/.devcontainer .
}
