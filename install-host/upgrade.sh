#!/bin/sh

RED='\033[0;31m';
NC='\033[0m';

ID=$(whoami);


upgrade_vuls() {
	echo -e "$RED""go-cve-dictionary upgrading...""$NC";
	cd $GOPATH/src/github.com/vulsio/go-cve-dictionary; 
	git pull
	make install;

	echo -e "$RED""goval-dictionary upgrading...""$NC";
	cd $GOPATH/src/github.com/vulsio/goval-dictionary;
	git pull
	make install;

	echo -e "$RED""gost(go-security-tracker) installing...""$NC";
	cd $GOPATH/src/github.com/vulsio/gost;
	git pull
	make install;

	echo -e "$RED""go-exploitdb installing...""$NC";	
	cd $GOPATH/src/github.com/vulsio/go-exploitdb;
	git pull
	make install;

	echo -e "$RED""go-msfdb installing...""$NC";	
	cd $GOPATH/src/github.com/vulsio/go-msfdb;
	git pull
	make install;

	echo -e "$RED""go-kev installing...""$NC";	
	cd $GOPATH/src/github.com/vulsio/go-kev;
	git pull
	make install;

	echo -e "$RED""Vuls installing...""$NC";
	cd $GOPATH/src/github.com/future-architect/vuls;
	git pull
	make install; 

	cp $GOPATH/bin/go-cve-dictionary /usr/local/bin/
	cp $GOPATH/bin/goval-dictionary /usr/local/bin/
	cp $GOPATH/bin/gost /usr/local/bin/
	cp $GOPATH/bin/go-exploitdb /usr/local/bin/
	cp $GOPATH/bin/go-msfdb /usr/local/bin/
	cp $GOPATH/bin/go-kev /usr/local/bin/
	cp $GOPATH/bin/vuls /usr/local/bin/
	echo "Done."; 
}

# https://github.com/namhyung/uftrace/blob/master/misc/install-deps.sh
if [ "x$(id -u)" != x0 ]; then
	echo "You might have to run it as root user."
	echo "Please run it again with 'sudo'."
	echo
	exit
fi

if [ -z "${GOPATH}" ]; then
	echo "You might have to set GOPATH"
	echo "Please run it again with GOPATH ENV Var"
	echo
	exit
fi

OPT="${@}"

distro=$(grep "^ID=" /etc/os-release | cut -d\= -f2 | sed -e 's/"//g')
if [ $distro = "" ]; then
	# Use the other way to detect the OS for CentOS 6.x
	distro=$(cat /etc/redhat-release | awk '{print tolower($1)}')
fi

case $distro in
	"ubuntu" | "debian" | "pop" | "raspbian" | "rhel" | "centos")
		upgrade_vuls;;
	*) # we can add more install command for each distros.
		echo "\"$distro\" is not supported distro, so please install packages manually." ;;
esac
