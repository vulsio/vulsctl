#! /bin/sh -

if [ $# -eq 0 ]; then
	echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora --suse]"
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
		goval-dictionary fetch amazon ${@} 2 2022 2023
		;;
	--debian)
		goval-dictionary fetch debian ${@} 10 11
		;;
	--ubuntu)
		goval-dictionary fetch ubuntu ${@} 14.04 16.04 18.04 20.04 22.04
		;;
	--alpine)
		goval-dictionary fetch alpine ${@} 3.14 3.15 3.16 3.17
		;;
	--oracle)
		goval-dictionary fetch oracle ${@} 7 8 9
		;;
	--fedora)
		goval-dictionary fetch fedora ${@} 34 35
		;;
	--suse)
		goval-dictionary fetch suse --suse-type suse-enterprise-server ${@} 12 15
		goval-dictionary fetch suse --suse-type opensuse tumbleweed
		goval-dictionary fetch suse --suse-type opensuse-leap 15.4
		;;
	--*)  echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora --suse]"
		exit 1
		;;
	*) echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora --suse]"
		exit 1
		;;
esac

exit 0

