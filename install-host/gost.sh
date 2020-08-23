#! /bin/sh -

if [ $# -eq 0 ]; then
	echo "specify [--redhat --debian]"
	exit 1
fi

target=$1
shift

case "$target" in
	--redhat) 
		gost fetch ${@} redhat
		;;
	--debian) 
		gost fetch ${@} debian
		;;
	--*)  echo "specify [--redhat --debian]"
		exit 1
	    ;;
	*) echo "specify [--redhat --debian]"
		exit 1
	    ;;
esac

exit 0

