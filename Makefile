DOCKER_COMPOSE := docker-compose -f srcs/docker-compose.yml
_END			:=	\033[0m
_GREEN			:=	\033[32m

all: up

up:	
	${DOCKER_COMPOSE} up -d --build

build:	
	${DOCKER_COMPOSE} build

start:
	$(DOCKER_COMPOSE) start

restart:
	$(DOCKER_COMPOSE) restart

down:
	$(DOCKER_COMPOSE) down

stop:
	$(DOCKER_COMPOSE) stop

logs:
	$(DOCKER_COMPOSE) logs -f
ls:
	@echo "$(_GREEN)------------------------List running containers-------------------------$(_END)"
	$(DOCKER_COMPOSE) ps
	@echo "$(_GREEN)------------------------------List images-------------------------------$(_END)"
	docker images
	@echo "$(_GREEN)------------------------------List volumes------------------------------$(_END)"
	docker volume ls
	@echo "$(_GREEN)------------------------------List networks------------------------------$(_END)"
	docker network ls
	
clean: down

fclean: clean
		rm -rf /home/gusimone/data/wordpress/*
		rm -rf /home/gusimone/data/mysql/*

prune: clean
		docker system prune -f -a

re: fclean all
 
.PHONY: all down ps restart logs re prune clean fclean ls stop start build up
