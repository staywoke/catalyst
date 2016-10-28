#!/bin/bash

set -euo pipefail

export COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-staywokecatalyst}"

# set up DOCKER_HOST automatically using docker-machine, if a DOCKER_MACHINE_NAME has been set
if [[ -f .docker-machine-name ]]; then
		export DOCKER_MACHINE_NAME="$(cat .docker-machine-name)"
fi

if [[ ${DOCKER_MACHINE_NAME:-} ]] && command -v docker-machine > /dev/null; then
  eval $(docker-machine env "${DOCKER_MACHINE_NAME}")
	export HOST_ADDRESS=$(docker-machine ip "${DOCKER_MACHINE_NAME}")
fi
