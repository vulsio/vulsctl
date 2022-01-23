#!/bin/bash

if [ $# -eq 0 ]; then
	echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle]"
	exit 1
fi

target=$1
shift

if [[ -z "${DOCKER_NETWORK}" ]]; then
	DOCKER_NETWORK_OPT=""
else
	DOCKER_NETWORK_OPT="--network ${DOCKER_NETWORK}"
fi


docker pull vuls/goval-dictionary
docker run --rm -it vuls/goval-dictionary version

case "$target" in
	--redhat) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch redhat ${@} 6 7 8 
		;;
	--amazon) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch amazon ${@} 
		;;
	--debian) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch debian ${@} 8 9 10 11
		;;
	--ubuntu) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch ubuntu ${@} 14.04 16.04 18.04 19.10 20.04 20.10 21.04 21.10
		;;
	--alpine) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch alpine ${@} 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 3.10 3.11 3.12 3.13 3.14
		;;
	--oracle) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch oracle ${@}
		;;
	--*)  echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle]"
		exit 1
		;;
	*) echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle]"
		exit 1
		;;
esac

exit 0

