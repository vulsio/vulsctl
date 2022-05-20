#! /bin/sh -

if [ $# -eq 0 ]; then
	echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora]"
	exit 1
fi

target=$1
shift

# NOTE: fetches oval of the OS with security support enabled.
case "$target" in
	--redhat)
		goval-dictionary fetch redhat ${@} 6 7 8 9
		;;
	--amazon)
		goval-dictionary fetch amazon ${@}
		;;
	--debian)
		goval-dictionary fetch debian ${@} 9 10 11
		;;
	--ubuntu)
		goval-dictionary fetch ubuntu ${@} 14 16 18 20 22
		;;
	--alpine)
		goval-dictionary fetch alpine ${@} 3.12 3.13 3.14 3.15
		;;
	--oracle)
		goval-dictionary fetch oracle ${@}
		;;
	--fedora)
		goval-dictionary fetch fedora ${@} 34 35
		;;
	--*)  echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora]"
		exit 1
		;;
	*) echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora]"
		exit 1
		;;
esac

exit 0

