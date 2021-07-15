#!/bin/bash

docker pull vuls/go-cve-dictionary

RELEASE=v0.15.10
URL=https://github.com/future-architect/vuls/releases/download/${RELEASE}/cve.sqlite3.gz 

if [[ -z "${DOCKER_NETWORK}" ]]; then
	DOCKER_NETWORK_OPT=""
else
	DOCKER_NETWORK_OPT="--network ${DOCKER_NETWORK}"
fi

if [ ! -e ./cve.sqlite3 ]; then
    echo "Fetching cve.sqlite3 from GitHub Vuls: ${URL}"
    curl -OL ${URL}
    gunzip ./cve.sqlite3.gz
fi

for i in `seq 2002 $(date +"%Y")`; do \
    docker run --rm -it \
    ${DOCKER_NETWORK_OPT} \
    -v $PWD:/vuls \
    vuls/go-cve-dictionary fetch nvd $@ --years $i; \
done

