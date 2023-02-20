#!make
include docker/variables.env
export

SHELL = bash
PWD ?= pwd_unknown
PROJECT_DIR = $(PWD)
PROJECT_NAME = $(notdir $(PWD))
CONTAINER_PREFIX = $(USER)-$(notdir $(PWD))
HOST_UID ?= $(strip $(if $(shell id -u),$(shell id -u),4000))
HOST_GID ?= $(strip $(if $(shell id -g),$(shell id -g),4444))

env:
	echo "PROJECT_DIR=$(PROJECT_DIR)" > docker/.env
	echo "PROJECT_NAME=$(PROJECT_NAME)" >> docker/.env
	echo "CONTAINER_PREFIX=$(CONTAINER_PREFIX)" >> docker/.env
	echo "HOST_GID=$(HOST_GID)" >> docker/.env
	echo "HOST_UID=$(HOST_UID)" >> docker/.env
	
	cat docker/variables.env >> docker/.env

build:
	make env && docker-compose -f docker/docker-compose.yml -p $(CONTAINER_PREFIX) build

start:
	docker-compose -f docker/docker-compose.yml -p $(CONTAINER_PREFIX) up -d 

stop:
	docker-compose -f docker/docker-compose.yml -p $(CONTAINER_PREFIX) stop 

shell:
	- docker exec -it  ${CONTAINER_PREFIX} /bin/sh -c "/entrypoint.sh bash"

notebook:
	- docker exec -it ${CONTAINER_PREFIX} /bin/sh -c "/entrypoint.sh notebook"

config: FORCE
	make env && docker-compose -f docker/datascience/docker-compose.yml config
FORCE: ;