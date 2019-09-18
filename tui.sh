#!/bin/sh

docker pull vuls/vuls

docker run --rm -it\
    -v $PWD:/vuls \
    vuls/vuls tui $@ \
    -log-dir=/vuls/log \
    -config=/vuls/config.toml\
    -refresh-cve \
    $@

