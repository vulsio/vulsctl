#!/bin/sh

RED='\033[0;31m';
NC='\033[0m';

ID=$(whoami);

go() {
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

# Download latest Golang shell script
# https://gist.github.com/n8henrie/1043443463a4a511acf98aaa4f8f0f69
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
	mkdir /var/log/go-exploitdb
	chown $ID /var/log/go-exploitdb
	chmod 700 /var/log/go-exploitdb
	mkdir -p $GOPATH/src/github.com/mozqnet;
	cd $GOPATH/src/github.com/mozqnet;
	git clone https://github.com/mozqnet/go-exploitdb.git;
	cd go-exploitdb;
	make install;

	echo -e "$RED""go-msfdb installing...""$NC";	
	cd $GOPATH/src/github.com/takuzoo3868/go-exploitdb;
	git pull
	make install;

	echo -e "$RED""Vuls installing...""$NC";
	cd $GOPATH/src/github.com/future-architect/vuls;
	git pull
	make install; 
	echo "Done."; 
}

# https://github.com/namhyung/uftrace/blob/master/misc/install-deps.sh
if [ "x$(id -u)" != x0 ]; then
	echo "You might have to run it as root user."
	echo "Please run it again with 'sudo'."
	echo
	exit
fi

OPT="${@}"

distro=$(grep "^ID=" /etc/os-release | cut -d\= -f2 | sed -e 's/"//g')
if [[ $distro == "" ]]; then
    # Use the other way to detect the OS for CentOS 6.x
    distro=$(cat /etc/redhat-release | awk '{print tolower($1)}')
fi

case $distro in
	"ubuntu" | "pop" | "raspbian" | "rhel" | "centos")
		upgrade_vuls;;
	*) # we can add more install command for each distros.
		echo "\"$distro\" is not supported distro, so please install packages manually." ;;
esac
