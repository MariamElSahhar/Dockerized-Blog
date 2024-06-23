.PHONY: build up down

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

run: build up

re: down run
