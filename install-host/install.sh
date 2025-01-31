#!/bin/sh

RED='\033[0;31m';
NC='\033[0m';

ID=$(whoami);

install_go() {
	export GOROOT=/usr/local/go;
	export GOPATH=$HOME/go;
	export PATH=$PATH:$GOROOT/bin:$GOPATH/bin;

	if command -v go > /dev/null
	then
		echo "Go is already installed."
		return
	fi

	url="https://golang.org/dl/$1"
	wget "${url}";
	echo -e "$RED""[!] Download successful : $url""$NC";
	tar -C /usr/local -xzf $1
	rm $1
	mkdir -p $HOME/go;
	echo "export GOROOT=/usr/local/go" >> "$HOME"/.profile;
	echo "export GOPATH=$HOME/go" >> "$HOME"/.profile;
	echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> "$HOME"/.profile;
}


# Download latest Golang shell script
# https://gist.github.com/n8henrie/1043443463a4a511acf98aaa4f8f0f69
install_vuls() {
	echo -e "$RED""go-cve-dictionary installing...""$NC";
	mkdir -p /var/log/go-cve-dictionary
	chown $ID /var/log/go-cve-dictionary
	chmod 700 /var/log/go-cve-dictionary
	mkdir -p $GOPATH/src/github.com/vulsio;
	cd $GOPATH/src/github.com/vulsio;
	git clone https://github.com/vulsio/go-cve-dictionary.git;
	cd $GOPATH/src/github.com/vulsio/go-cve-dictionary;
	make install;
	#ln -s $GOPATH/src/github.com/vulsio/go-cve-dictionary/cve.sqlite3 $HOME/cve.sqlite3;

	echo -e "$RED""goval-dictionary installing...""$NC";
	mkdir -p /var/log/goval-dictionary
	chown $ID /var/log/goval-dictionary
	chmod 700 /var/log/goval-dictionary
	mkdir -p $GOPATH/src/github.com/vulsio;
	cd $GOPATH/src/github.com/vulsio;
	git clone https://github.com/vulsio/goval-dictionary.git;
	cd $GOPATH/src/github.com/vulsio/goval-dictionary;
	make install;
	#ln -s $GOPATH/src/github.com/vulsio/goval-dictionary/oval.sqlite3 $HOME/oval.sqlite3;

	echo -e "$RED""gost(go-security-tracker) installing...""$NC";
	mkdir -p /var/log/gost
	chown $ID /var/log/gost
	chmod 700 /var/log/gost
	mkdir -p $GOPATH/src/github.com/vulsio;
	cd $GOPATH/src/github.com/vulsio;
	git clone https://github.com/vulsio/gost.git;
	cd gost;
	make install;
	#ln -s $GOPATH/src/github.com/vulsio/gost/gost.sqlite3 $HOME/gost.sqlite3;

	echo -e "$RED""go-exploitdb installing...""$NC";
	mkdir -p /var/log/go-exploitdb
	chown $ID /var/log/go-exploitdb
	chmod 700 /var/log/go-exploitdb
	mkdir -p $GOPATH/src/github.com/vulsio;
	cd $GOPATH/src/github.com/vulsio;
	git clone https://github.com/vulsio/go-exploitdb.git;
	cd go-exploitdb;
	make install;
	#ln -s $GOPATH/src/github.com/vulsio/go-exploitdb/go-exploitdb.sqlite3 $HOME/go-exploitdb.sqlite3;

	echo -e "$RED""go-msfdb installing...""$NC";
	mkdir -p /var/log/go-msfdb
	chown $ID /var/log/go-msfdb
	chmod 700 /var/log/go-msfdb
	mkdir -p $GOPATH/src/github.com/vulsio
	cd $GOPATH/src/github.com/vulsio/
	git clone https://github.com/vulsio/go-msfdb.git
	cd go-msfdb;
	make install;
	#ln -s $GOPATH/src/github.com/vulsio/go-msfdb/go-msfdb.sqlite3 $HOME/go-msfdb.sqlite3;

	echo -e "$RED""go-kev installing...""$NC";
	mkdir -p /var/log/go-kev
	chown $ID /var/log/go-kev
	chmod 700 /var/log/go-kev
	mkdir -p $GOPATH/src/github.com/vulsio
	cd $GOPATH/src/github.com/vulsio/
	git clone https://github.com/vulsio/go-kev.git
	cd go-kev;
	make install;
	#ln -s $GOPATH/src/github.com/vulsio/go-kev/go-kev.sqlite3 $HOME/go-kev.sqlite3;

	echo -e "$RED""go-cti installing...""$NC";
	mkdir -p /var/log/go-cti
	chown $ID /var/log/go-cti
	chmod 700 /var/log/go-cti
	mkdir -p $GOPATH/src/github.com/vulsio
	cd $GOPATH/src/github.com/vulsio/
	git clone https://github.com/vulsio/go-cti.git
	cd go-cti;
	make install;
	#ln -s $GOPATH/src/github.com/vulsio/go-cti/go-cti.sqlite3 $HOME/go-cti.sqlite3;

	echo -e "$RED""Vuls installing...""$NC";
	mkdir -p /var/log/vuls;
	chown $ID /var/log/vuls
	chmod 700 /var/log/vuls
	mkdir -p $GOPATH/src/github.com/future-architect;
	cd $GOPATH/src/github.com/future-architect;
	git clone https://github.com/future-architect/vuls.git;
	cd vuls;
	make install;

	cp $GOPATH/bin/go-cve-dictionary /usr/local/bin/
	cp $GOPATH/bin/goval-dictionary /usr/local/bin/
	cp $GOPATH/bin/gost /usr/local/bin/
	cp $GOPATH/bin/go-exploitdb /usr/local/bin/
	cp $GOPATH/bin/go-msfdb /usr/local/bin/
	cp $GOPATH/bin/go-kev /usr/local/bin/
	cp $GOPATH/bin/go-cti /usr/local/bin/
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

OPT="${@}"

distro=$(grep "^ID=" /etc/os-release | cut -d\= -f2 | sed -e 's/"//g')
if [ $distro = "" ]; then
	# Use the other way to detect the OS for CentOS 6.x
	distro=$(cat /etc/redhat-release | awk '{print tolower($1)}')
fi

case $distro in
	"ubuntu" | "debian" | "kali" | "pop")
		apt-get update
		apt-get $OPT install sqlite3 git gcc make wget
		filename="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)";
		install_go $filename
		install_vuls;;
	"raspbian")
		apt-get update
		apt-get $OPT install sqlite3 git gcc make wget
		filename="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-armv6l.tar\.gz' | head -n 1)";
		install_go $filename
		install_vuls;;
	"rhel" | "centos")
		yum $OPT install sqlite git gcc make wget
		filename="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)";
		install_go $filename
		install_vuls;;
	"fedora")
		dnf $OPT install sqlite git gcc make wget
		filename="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)";
		install_go $filename
		install_vuls;;
	"alpine")
		apk add $OPT sqlite git gcc make wget
		filename="$(wget -qO- https://golang.org/dl/ | grep -oE 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)";
		install_go $filename
		install_vuls;;
	"amzn")
		# For Amazon Linux 2 (amzn)
		yum $OPT install sqlite git gcc make wget
		filename="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)";
		install_go $filename
		install_vuls;;
	*) # we can add more install command for each distros.
		echo "\"$distro\" is not supported distro, so please install packages manually." ;;
esac