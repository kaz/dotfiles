function dbup
	cd ~/.database/$argv[1]
	docker-compose up -d
	cd -
end
