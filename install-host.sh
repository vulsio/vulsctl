#!/bin/sh

RED='\033[0;31m';
NC='\033[0m';

ID=$(whoami);

# Download latest Golang shell script
# https://gist.github.com/n8henrie/1043443463a4a511acf98aaa4f8f0f69
ubuntu() {
	echo "$RED""Finding latest version of Go for AMD64...""$NC";
	url="$(wget -qO- https://golang.org/dl/ | grep -oP 'https:\/\/dl\.google\.com\/go\/go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 )";
	latest="$(echo $url | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2 )";
	wget "${url}";
	echo "$RED""[!] Download successful : $url""$NC";
	tar -C /usr/local -xzf go$latest.linux-amd64.tar.gz;
	mkdir $HOME/go;
	export GOROOT=/usr/local/go;
	export GOPATH=$HOME/go;
	export PATH=$PATH:$GOROOT/bin:$GOPATH/bin;
	echo "export GOROOT=/usr/local/go" >> "$HOME"/.profile;
	echo "export GOPATH=$HOME/go" >> "$HOME"/.profile;
	echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> "$HOME"/.profile;
	echo "$RED""go-cve-dictionary + goval-dictionary installing...""$NC";
	mkdir /var/log/vuls;
	chown $ID /var/log/vuls
	chmod 700 /var/log/vuls
	mkdir -p $GOPATH/src/github.com/kotakanbe;
	cd $GOPATH/src/github.com/kotakanbe;
	git clone https://github.com/kotakanbe/go-cve-dictionary.git;
	git clone https://github.com/kotakanbe/goval-dictionary.git;
	cd $GOPATH/src/github.com/kotakanbe/go-cve-dictionary; 
	make install;
	cd $GOPATH/src/github.com/kotakanbe/goval-dictionary;
	make install;
	ln -s $GOPATH/src/github.com/kotakanbe/goval-dictionary/oval.sqlite3 $HOME/oval.sqlite3;
	echo "$RED""gost(go-security-tracker) installing...""$NC";
	mkdir /var/log/gost
	chown $ID /var/log/gost;
	chmod 700 /var/log/gost;
	mkdir -p $GOPATH/src/github.com/knqyf263;
	cd $GOPATH/src/github.com/knqyf263;
	git clone https://github.com/knqyf263/gost.git;
	cd gost;
	make install;
	ln -s $GOPATH/src/github.com/knqyf263/gost/gost.sqlite3 $HOME/gost.sqlite3;
	echo "$RED""go-exploitdb installing...""$NC";	
	mkdir /var/log/go-exploitdb
	chown $ID /var/log/go-exploitdb
	chmod 700 /var/log/go-exploitdb
	mkdir -p $GOPATH/src/github.com/mozqnet;
	cd $GOPATH/src/github.com/mozqnet;
	git clone https://github.com/mozqnet/go-exploitdb.git;
	cd go-exploitdb;
	make install;
	ln -s $GOPATH/src/github.com/mozqnet/go-exploitdb/go-exploitdb.sqlite3 $HOME/go-exploitdb.sqlite3;
	echo "$RED""Vuls installing...""$NC";
	mkdir -p $GOPATH/src/github.com/future-architect;
	cd $GOPATH/src/github.com/future-architect;
	git clone https://github.com/future-architect/vuls.git;
	cd vuls;
	make install; 
	cp $GOPATH/bin/go-cve-dictionary /usr/local/bin/
	cp $GOPATH/bin/go-exploitdb /usr/local/bin/
	cp $GOPATH/bin/gost /usr/local/bin/
	cp $GOPATH/bin/goval-dictionary /usr/local/bin/
	cp $GOPATH/bin/vuls /usr/local/bin/
	echo "Done."; 
}

centos() {
	echo "$RED""Finding latest version of Go for AMD64...""$NC";
	url="$(wget -qO- https://golang.org/dl/ | grep -oP 'https:\/\/dl\.google\.com\/go\/go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 )";
	latest="$(echo $url | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2 )";
	wget "${url}";
	echo "$RED""[!] Download successful : $url""$NC";
	tar -C /usr/local -xzf go$latest.linux-amd64.tar.gz;
	mkdir $HOME/go;
	export GOROOT=/usr/local/go;
	export GOPATH=$HOME/go;
	export PATH=$PATH:$GOROOT/bin:$GOPATH/bin;
	echo "export GOROOT=/usr/local/go" >> /etc/profile.d/goenv.sh;
	echo "export GOPATH=$HOME/go" >> /etc/profile.d/goenv.sh;
	echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> /etc/profile.d/goenv.sh;
	echo "$RED""go-cve-dictionary + goval-dictionary installing...""$NC";
	mkdir /var/log/vuls;
	chown $ID /var/log/vuls
	chmod 700 /var/log/vuls
	mkdir -p $GOPATH/src/github.com/kotakanbe;
	cd $GOPATH/src/github.com/kotakanbe;
	git clone https://github.com/kotakanbe/go-cve-dictionary.git;
	git clone https://github.com/kotakanbe/goval-dictionary.git;
	cd $GOPATH/src/github.com/kotakanbe/go-cve-dictionary; 
	make install;
	cd $GOPATH/src/github.com/kotakanbe/goval-dictionary;
	make install;
	ln -s $GOPATH/src/github.com/kotakanbe/goval-dictionary/oval.sqlite3 $HOME/oval.sqlite3;
	echo "$RED""gost(go-security-tracker) installing...""$NC";
	mkdir /var/log/gost
	chown $ID /var/log/gost;
	chmod 700 /var/log/gost;
	mkdir -p $GOPATH/src/github.com/knqyf263;
	cd $GOPATH/src/github.com/knqyf263;
	git clone https://github.com/knqyf263/gost.git;
	cd gost;
	make install;
	ln -s $GOPATH/src/github.com/knqyf263/gost/gost.sqlite3 $HOME/gost.sqlite3;
	echo "$RED""go-exploitdb installing...""$NC";	
	mkdir /var/log/go-exploitdb
	chown $ID /var/log/go-exploitdb
	chmod 700 /var/log/go-exploitdb
	mkdir -p $GOPATH/src/github.com/mozqnet;
	cd $GOPATH/src/github.com/mozqnet;
	git clone https://github.com/mozqnet/go-exploitdb.git;
	cd go-exploitdb;
	make install;
	ln -s $GOPATH/src/github.com/mozqnet/go-exploitdb/go-exploitdb.sqlite3 $HOME/go-exploitdb.sqlite3;
	echo "$RED""Vuls installing...""$NC";
	mkdir -p $GOPATH/src/github.com/future-architect;
	cd $GOPATH/src/github.com/future-architect;
	git clone https://github.com/future-architect/vuls.git;
	cd vuls;
	make install; 
	cp $GOPATH/bin/go-cve-dictionary /usr/local/bin/
	cp $GOPATH/bin/go-exploitdb /usr/local/bin/
	cp $GOPATH/bin/gost /usr/local/bin/
	cp $GOPATH/bin/goval-dictionary /usr/local/bin/
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

case $distro in
	"ubuntu")
		apt-get $OPT install sqlite git gcc make wget
		ubuntu;;
	"rhel" | "centos")
		yum install $OPT sqlite git gcc make wget
		centos;;
	*) # we can add more install command for each distros.
		echo "\"$distro\" is not supported distro, so please install packages manually." ;;
esac
