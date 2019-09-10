dbup () {
	CurDir=`pwd`
	cd ~/.database/$1
	docker-compose up -d
	cd $CurDir
}
devcontainer() {
	ln -sf ~/.devcontainer .
}
