#!/bin/bash

set -euo pipefail

# This script is the ENTRYPOINT defined in the Dockerfile, and it's purpose is to prepare the environment for running the process in the container to use in the app.

report() {
	[[ ${DEV_MODE} == false ]] && return
	printf "[entrypoint.sh] %s\n" "$1" >&2
}

export() {
	for assign in "$@"; do
		builtin export -- "$assign"
		name="${assign%%=*}"
		value="$(eval "echo \$${name}")"
		[[ ${ENTRYPOINT_TRACE:-} ]] && report "${name}='${value}'" || :
	done
}

export CI="${CI:-false}"
export DEV_MODE="${DEV_MODE:-false}"

if [[ ${DEV_MODE} != false && ! $1 =~ bundle|bash ]]; then
		bundle check || bundle install || :
fi

report "exec $*"
exec $@
