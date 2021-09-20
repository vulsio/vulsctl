#!/bin/bash

docker pull vuls/go-cve-dictionary

if [[ -z "${DOCKER_NETWORK}" ]]; then
	DOCKER_NETWORK_OPT=""
else
	DOCKER_NETWORK_OPT="--network ${DOCKER_NETWORK}"
fi

docker run --rm -it vuls/go-cve-dictionary version

docker run --rm -it \
    ${DOCKER_NETWORK_OPT} \
    -v $PWD:/go-cve-dictionary \
    vuls/go-cve-dictionary fetch nvd $@
