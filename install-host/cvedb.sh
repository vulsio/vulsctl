#! /bin/sh -

if [ $# -eq 0 ]; then
	echo "specify [--nvd --jvn --fortinet --mitre --paloalto --cisco]"
	exit 1
fi

target=$1
shift

case "$target" in
	--nvd)
		go-cve-dictionary fetch ${@} nvd
		;;
	--jvn)
		go-cve-dictionary fetch ${@} jvn
		;;
	--fortinet)
		go-cve-dictionary fetch ${@} fortinet
		;;
	--mitre)
		go-cve-dictionary fetch ${@} mitre
		;;
	--paloalto)
		go-cve-dictionary fetch ${@} paloalto
		;;
	--cisco)
		go-cve-dictionary fetch ${@} cisco
		;;
	--*)  echo "specify [--nvd --jvn --fortinet --mitre --paloalto --cisco]"
		exit 1
		;;
	*) echo "specify [--nvd --jvn --fortinet --mitre --paloalto --cisco]"
		exit 1
		;;
esac

exit 0
