#!/bin/bash 

if [ $# -eq 0 ]; then
	echo "specify [--nvd --jvn --fortinet --mitre --paloalto --cisco]"
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

docker pull vuls/go-cve-dictionary
docker run --rm -i $T vuls/go-cve-dictionary version

case "$target" in
	--nvd) docker run --rm -i $T \
		-v ${PWD}:/go-cve-dictionary \
		${DOCKER_NETWORK_OPT} \
		vuls/go-cve-dictionary fetch ${@} nvd
		;;
	--jvn) docker run --rm -i $T \
		-v ${PWD}:/go-cve-dictionary \
		${DOCKER_NETWORK_OPT} \
		vuls/go-cve-dictionary fetch ${@} jvn
		;;
	--fortinet) docker run --rm -i $T \
		-v ${PWD}:/go-cve-dictionary \
		${DOCKER_NETWORK_OPT} \
		vuls/go-cve-dictionary fetch ${@} fortinet
		;;
	--mitre) docker run --rm -i $T \
		-v ${PWD}:/go-cve-dictionary \
		${DOCKER_NETWORK_OPT} \
		vuls/go-cve-dictionary fetch ${@} mitre
		;;
	--paloalto) docker run --rm -i $t \
		-v ${PWD}:/go-cve-dictionary \
		${DOCKER_NETWORK_OPT} \
		vuls/go-cve-dictionary fetch ${@} paloalto
		;;
	--cisco) docker run --rm -i $t \
		-v ${PWD}:/go-cve-dictionary \
		${DOCKER_NETWORK_OPT} \
		vuls/go-cve-dictionary fetch ${@} cisco
		;;
	--*)  echo "specify [--nvd --jvn --fortinet --mitre --paloalto --cisco]"
		exit 1
	    ;;
	*) echo "specify [--nvd --jvn --fortinet --mitre --paloalto --cisco]"
		exit 1
	    ;;
esac

exit 0