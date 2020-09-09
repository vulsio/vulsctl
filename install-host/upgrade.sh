#!/bin/sh

RED='\033[0;31m';
NC='\033[0m';

ID=$(whoami);

install_go() {
	if command -v go &> /dev/null
	then
		echo "Go is already installed."
		return
	fi

	echo -e "\n${RED} [!] Go is not installed. Proceed to install...${NC}\n"
	url="https://golang.org/dl/$1"
	wget "${url}";
	echo -e "$RED""[!] Download successful : $url""$NC";
	tar -C /usr/local -xzf $1
	mkdir $HOME/go;
	export GOROOT=/usr/local/go;
	export GOPATH=$HOME/go;
	export PATH=$PATH:$GOROOT/bin:$GOPATH/bin;
	echo "export GOROOT=/usr/local/go" >> "$HOME"/.profile;
	echo "export GOPATH=$HOME/go" >> "$HOME"/.profile;
	echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> "$HOME"/.profile;
}

upgrade_vuls() {
	echo -e "$RED""go-cve-dictionary + goval-dictionary upgrading...""$NC";
	cd $GOPATH/src/github.com/kotakanbe/go-cve-dictionary; 
	git pull
	make install;
	cd $GOPATH/src/github.com/kotakanbe/goval-dictionary;
	git pull
	make install;

	echo -e "$RED""gost(go-security-tracker) installing...""$NC";
	mkdir -p $GOPATH/src/github.com/knqyf263;
	cd $GOPATH/src/github.com/knqyf263/gost;
	git pull
	make install;

	echo -e "$RED""go-exploitdb installing...""$NC";	
	cd $GOPATH/src/github.com/mozqnet/go-exploitdb;
	git pull
	make install;

	echo -e "$RED""go-msfdb installing...""$NC";	
	cd $GOPATH/src/github.com/takuzoo3868/go-msfdb;
	git pull
	make install;

	echo -e "$RED""Vuls installing...""$NC";
	cd $GOPATH/src/github.com/future-architect/vuls;
	git pull
	make install; 

	cp $GOPATH/bin/go-cve-dictionary /usr/local/bin/
	cp $GOPATH/bin/go-exploitdb /usr/local/bin/
	cp $GOPATH/bin/gost /usr/local/bin/
	cp $GOPATH/bin/goval-dictionary /usr/local/bin/
	cp $GOPATH/bin/vuls /usr/local/bin/
	cp $GOPATH/bin/go-msfdb /usr/local/bin/
	echo "Done."; 
}

# https://github.com/namhyung/uftrace/blob/master/misc/install-deps.sh
if [ "x$(id -u)" != x0 ]; then
	echo "You might have to run it as root user."
	echo "Please run it again with 'sudo'."
	echo
	exit
fi

#if [ -z "${GOPATH}" ]; then
#	echo "You might have to set GOPATH"
#	echo "Please run it again with GOPATH ENV Var"
#	echo
#	exit
#fi

OPT="${@}"

distro=$(grep "^ID=" /etc/os-release | cut -d\= -f2 | sed -e 's/"//g')
if [ $distro = "" ]; then
	# Use the other way to detect the OS for CentOS 6.x
	distro=$(cat /etc/redhat-release | awk '{print tolower($1)}')
fi

case $distro in
	"ubuntu" | "pop")
		apt-get update
		apt-get $OPT install sqlite git gcc make wget
		filename="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)";
		install_go $filename
		upgrade_vuls;;
	"raspbian")
		apt-get update
		apt-get $OPT install sqlite git gcc make wget
		filename="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-armv6l.tar\.gz' | head -n 1)";
		install_go $filename
		upgrade_vuls;;
	"rhel" | "centos")
		yum $OPT install sqlite git gcc make wget
		filename="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)";
		install_go $filename
		upgrade_vuls;;
	*) # we can add more install command for each distros.
		echo "\"$distro\" is not supported distro, so please install packages manually." ;;
esac
