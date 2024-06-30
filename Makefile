DOCKER = docker-compose -f srcs/docker-compose.yml

build:
	${DOCKER} build

up:
	${DOCKER} up -d

down:
	${DOCKER} down

run: build up

re: down run

prune: down
	docker system prune --all --force --volumes
	sudo rm -rf /home/${USER}/data

logs:
	${DOCKER} logs -f

eval:
	docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null

.PHONY: build up down re run logs prune
