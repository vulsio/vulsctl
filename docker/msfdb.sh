#!/bin/bash

docker pull vuls/go-msfdb

if [[ -z "${DOCKER_NETWORK}" ]]; then
	DOCKER_NETWORK_OPT=""
else
	DOCKER_NETWORK_OPT="--network ${DOCKER_NETWORK}"
fi

docker run --rm -it vuls/go-msfdb version

docker run --rm -it \
    ${DOCKER_NETWORK_OPT} \
    -v $PWD:/go-msfdb \
    vuls/go-msfdb fetch msfdb ${@}

