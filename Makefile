.PHONY: build up down re run logs prune

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

run: build up

re: down run

prune: down
	docker system prune --all --force --volumes
	sudo rm -rf /home/${USER}/data

logs:
	docker-compose logs
