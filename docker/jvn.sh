#!/bin/bash

docker pull vuls/go-cve-dictionary

if [[ -z "${DOCKER_NETWORK}" ]]; then
	DOCKER_NETWORK_OPT=""
else
	DOCKER_NETWORK_OPT="--network ${DOCKER_NETWORK}"
fi

for i in `seq 1998 $(date +"%Y")`; do \
    docker run --rm -it \
    ${DOCKER_NETWORK_OPT} \
    -v $PWD:/go-cve-dictionary \
    vuls/go-cve-dictionary fetch jvn $@ --years $i; \
done
