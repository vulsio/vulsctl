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

if [[ $(tty) =~ "not a tty" ]]
then
    t=''
else
    t="-t"
fi

docker pull vuls/gost
docker run --rm -i $t vuls/gost version

case "$target" in
	--redhat) docker run --rm -i $t \
		-v ${PWD}:/gost \
		${DOCKER_NETWORK_OPT} \
		vuls/gost fetch ${@} redhat
		;;
	--debian) docker run --rm -i $t \
		-v ${PWD}:/gost \
		${DOCKER_NETWORK_OPT} \
		vuls/gost fetch ${@} debian
		;;
	--ubuntu) docker run --rm -i $t \
		-v ${PWD}:/gost \
		${DOCKER_NETWORK_OPT} \
		vuls/gost fetch ${@} ubuntu
		;;
	--microsoft) docker run --rm -i $t \
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

