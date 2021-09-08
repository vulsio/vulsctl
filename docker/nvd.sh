#!/bin/bash

docker pull vuls/go-cve-dictionary

if [[ -z "${DOCKER_NETWORK}" ]]; then
	DOCKER_NETWORK_OPT=""
else
	DOCKER_NETWORK_OPT="--network ${DOCKER_NETWORK}"
fi

if [[ $(tty) =~ "not a tty" ]]
then
    t=''
else
    t="-t"
fi

for i in `seq 2002 $(date +"%Y")`; do \
    docker run --rm -i $t \
    ${DOCKER_NETWORK_OPT} \
    -v $PWD:/go-cve-dictionary \
    vuls/go-cve-dictionary fetch nvd $@ --years $i; \
done

