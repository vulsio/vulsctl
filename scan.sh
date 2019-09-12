#!/bin/sh

docker pull vuls/vuls

docker run --rm -it\
    -v /home/centos/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    vuls/vuls configtest \
    -log-dir=/vuls \
    -config=/vuls/config.toml # path to config.toml in docker

docker run --rm -it\
    -v /home/centos/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    vuls/vuls scan \
    -log-dir=/vuls \
    -config=/vuls/config.toml \
    $@ 

