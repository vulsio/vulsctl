#!/bin/bash

docker pull vuls/go-cti

if [[ -z "${DOCKER_NETWORK}" ]]; then
	DOCKER_NETWORK_OPT=""
else
	DOCKER_NETWORK_OPT="--network ${DOCKER_NETWORK}"
fi

SELF=$$
ls /proc/$SELF/fd/0 -l | grep /dev/pts > /dev/null
if [ $? -eq 0 ]; then
        echo "input device is TTY device"
        T=-t
else
        echo "input device is non TTY"
        T=
fi

docker run --rm -i $T vuls/go-cti version

docker run --rm -i $T \
    ${DOCKER_NETWORK_OPT} \
    -v $PWD:/go-cti \
    vuls/go-cti fetch threat ${@}
