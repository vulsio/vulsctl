#! /bin/sh -

if [ $# -eq 0 ]; then
	echo "specify [--redhat --amazon --debian --ubuntu --alpine]"
	exit 1
fi

target=$1
shift

docker pull vuls/goval-dictionary

case "$target" in
	--redhat) docker run --rm -it \
		-v $PWD:/vuls \
		vuls/goval-dictionary fetch-redhat ${@} 6 7 8 
		;;
	--amazon) docker run --rm -it \
		-v $PWD:/vuls \
		vuls/goval-dictionary fetch-amazon ${@} 
		;;
	--debian) docker run --rm -it \
		-v $PWD:/vuls \
		vuls/goval-dictionary fetch-debian ${@} 8 9 10
		;;
	--ubuntu) docker run --rm -it \
		-v $PWD:/vuls \
		vuls/goval-dictionary fetch-ubuntu ${@} 16 18 
		;;
	--alpine) docker run --rm -it \
		-v $PWD:/vuls \
		vuls/goval-dictionary fetch-alpine ${@} 3.3 3.4 3.5 3.6 3.7 3.8 3.9 3.10
		;;
	--*)  echo "specify [--redhat --amazon --debian --ubuntu --alpine]"
		exit 1
		;;
	*) echo "specify [--redhat --amazon --debian --ubuntu --alpine]"
		exit 1
		;;
esac

exit 0

