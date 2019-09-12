#!/bin/sh

docker pull vuls/vuls

docker run --rm -it\
    -v /home/centos/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    vuls/vuls report \
    -log-dir=/vuls \
    -format-list \
    -config=/vuls/config.toml \
    -refresh-cve \
    $@

