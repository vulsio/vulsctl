#!/bin/bash

if [ $# -eq 0 ]; then
	echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora --suse]"
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


docker pull vuls/goval-dictionary
docker run --rm -i $t vuls/goval-dictionary version

# NOTE: fetches oval of the OS with security support enabled.
case "$target" in
	--redhat) docker run --rm -i $t \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch redhat ${@} 6 7 8 9
		;;
	--amazon) docker run --rm -i $t \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch amazon ${@} 2 2022 2023
		;;
	--debian) docker run --rm -i $t \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch debian ${@} 10 11 12
		;;
	--ubuntu) docker run --rm -i $t \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch ubuntu ${@} 14.04 16.04 18.04 20.04 22.04
		;;
	--alpine) docker run --rm -i $t \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch alpine ${@} 3.14 3.15 3.16 3.17
		;;
	--oracle) docker run --rm -i $t \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch oracle ${@} 7 8 9
		;;
	--fedora) docker run --rm -i $t \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch fedora ${@} 34 35
		;;
	--suse) docker run --rm -i $t \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch suse --suse-type suse-enterprise-server ${@} 12 15

		docker run --rm -i $t \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch suse --suse-type opensuse tumbleweed

		docker run --rm -i $t \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch suse --suse-type opensuse-leap 15.4
		;;
	--*)  echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora --suse]"
		exit 1
		;;
	*) echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora --suse]"
		exit 1
		;;
esac

exit 0

