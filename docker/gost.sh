#!/bin/bash 

if [ $# -eq 0 ]; then
	echo "specify [--redhat --debian --ubuntu --microsoft]"
	exit 1
fi

target=$1
shift

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

docker pull vuls/gost
docker run --rm -i $T vuls/gost version

case "$target" in
	--redhat) docker run --rm -i $T \
		-v ${PWD}:/gost \
		${DOCKER_NETWORK_OPT} \
		vuls/gost fetch ${@} redhat
		;;
	--debian) docker run --rm -i $T \
		-v ${PWD}:/gost \
		${DOCKER_NETWORK_OPT} \
		vuls/gost fetch ${@} debian
		;;
	--ubuntu) docker run --rm -i $T \
		-v ${PWD}:/gost \
		${DOCKER_NETWORK_OPT} \
		vuls/gost fetch ${@} ubuntu
		;;
	--microsoft) docker run --rm -i $T \
		-v ${PWD}:/gost \
		${DOCKER_NETWORK_OPT} \
		vuls/gost fetch ${@} microsoft
		;;
	--*)  echo "specify [--redhat --debian --ubuntu --microsoft]"
		exit 1
	    ;;
	*) echo "specify [--redhat --debian --ubuntu --microsoft]"
		exit 1
	    ;;
esac

exit 0

