SHELL := /bin/bash

.PHONY: build up down shell clean status

export HOST_IP = $(shell ipconfig getifaddr en0) 

build:
	docker-compose build

up:
	open -a XQuartz
	xhost + ${HOST_IP}
	docker-compose up -d

down:
	docker-compose down

shell:
	docker exec -it dockervscode_ide_1 /bin/bash

clean: export CONTAINER_IDS=$(shell docker ps -qa --no-trunc --filter "status=exited")
clean:
	docker rm $(CONTAINER_IDS)

status:
	docker ps -a
