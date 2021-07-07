#! /bin/sh -

if [ $# -eq 0 ]; then
	echo "specify [--redhat --debian --ubuntu]"
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
	--ubuntu) 
		gost fetch ${@} ubuntu
		;;
	--*)  echo "specify [--redhat --debian --ubuntu]"
		exit 1
	    ;;
	*) echo "specify [--redhat --debian --ubuntu]"
		exit 1
	    ;;
esac

exit 0

