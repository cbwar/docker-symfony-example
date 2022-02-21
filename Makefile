.PHONY: build
build:
	docker exec -ti my-app symfony composer install
	docker exec -ti my-app symfony console d:s:u --force
	docker exec -ti my-app symfony console assets:inst --relative --symlink

.PHONY: db
db:
	docker exec -ti my-app symfony console d:d:c
	docker exec -ti my-app symfony console d:s:u --force

.PHONY: run
run:
	docker-compose up --build -d

.PHONY: test
test:
	docker exec -ti my-app symfony console d:s:u --force --env=test
	docker exec -ti my-app symfony php vendor/bin/phpunit
