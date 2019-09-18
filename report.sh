#!/bin/sh

docker pull vuls/vuls

docker run --rm -it\
    -v $PWD:/vuls \
    vuls/vuls report \
    -log-dir=/vuls/log \
    -format-list \
    -config=/vuls/config.toml \
    -refresh-cve \
    $@

