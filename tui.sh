#!/bin/sh

docker pull vuls/vuls

docker run --rm -it\
    -v /home/centos/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    vuls/vuls tui $@ \
    -log-dir=/vuls \
    -config=/vuls/config.toml\
    -refresh-cve \
    $@

