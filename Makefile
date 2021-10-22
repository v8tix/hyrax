include .envrc

# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

# ==================================================================================== #
# DEVELOPMENT
# ==================================================================================== #

## cont/run: runs the container in the background
.PHONY: cont/run
cont/run:
	@docker run -t --rm --name "${IMAGE}" --hostname "${IMAGE}" -d "${IMAGE_TAG}"

## cont/attach: attaches the running container
.PHONY: cont/attach
cont/attach:
	@docker exec -it "${IMAGE}" bash

## cont/stop: stop the running container
.PHONY: cont/stop
cont/stop:
	@docker stop "${IMAGE}"

## cont/delete: stop and delete the image
.PHONY: cont/delete
cont/delete: cont/stop
	@docker rmi "${IMAGE_TAG}"

## repo/merge: merge into master
.PHONY: repo/merge
repo/merge:
	@git checkout master
	@git pull origin master
	@git merge "${TAG}"
	@git push origin master

# ==================================================================================== #
# BUILD
# ==================================================================================== #
## cont/build: builds the container image
.PHONY: cont/build
cont/build:
	@docker build --no-cache  -f ./build/Dockerfile -t ${IMAGE_TAG} .

# ==================================================================================== #
# DOCKER HUB
# ==================================================================================== #
COMMIT=$(shell git describe --always --dirty)
DOCKER_TAG=${DOCKER_ACCOUNT}/${IMAGE_TAG}.${COMMIT}

## cont/push: push the container image to Docker Hub
.PHONY: cont/push
cont/push:
	@docker tag ${IMAGE_TAG} ${DOCKER_TAG}
	@docker push ${DOCKER_TAG}








