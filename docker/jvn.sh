#!/bin/bash

docker pull vuls/go-cve-dictionary

# TODO
#RELEASE=v0.13.1
#URL=https://github.com/future-architect/vuls/releases/download/${RELEASE}/cve.sqlite3.gz 

if [[ -z "${DOCKER_NETWORK}" ]]; then
	DOCKER_NETWORK_OPT=""
else
	DOCKER_NETWORK_OPT="--network ${DOCKER_NETWORK}"
fi

for i in `seq 1998 $(date +"%Y")`; do \
    docker run --rm -it \
    ${DOCKER_NETWORK_OPT} \
    -v $PWD:/vuls \
    vuls/go-cve-dictionary fetchjvn $@ -years $i; \
done
