#!/bin/sh

docker pull vuls/vuls

docker run --rm -it\
    -v $HOME/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    vuls/vuls configtest \
    -log-dir=/vuls/log \
    -config=/vuls/config.toml # path to config.toml in docker

ret=$?
if [ $ret -ne 0 ]; then
	exit 1
fi

docker run --rm -it\
    -v $HOME/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    vuls/vuls scan \
    -log-dir=/vuls/log \
    -config=/vuls/config.toml \
    $@ 

