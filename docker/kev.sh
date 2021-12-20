#!/bin/bash

docker pull vuls/go-kev

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

docker run --rm -i $t vuls/go-kev version

docker run --rm -i $t \
    ${DOCKER_NETWORK_OPT} \
    -v $PWD:/go-kev \
    vuls/go-kev fetch kevuln ${@}
