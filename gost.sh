#! /bin/sh -

docker pull vuls/gost

if [ $# -ne 1 ]; then
	echo "specify [--redhat --debian]"
	exit 1
fi

while test $# -gt 0
do
	case "$1" in
		--redhat) docker run --rm -it \
			-v $PWD:/vuls \
			vuls/gost fetch redhat
			;;
		--debian) docker run --rm -it \
			-v $PWD:/vuls \
			vuls/gost fetch debian
			;;
		--*)  echo "specify [--redhat --debian]"
			exit 1
		    ;;
		*) echo "specify [--redhat --debian]"
			exit 1
		    ;;
	esac
	shift
done

exit 0

