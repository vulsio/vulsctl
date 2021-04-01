#!/bin/bash

docker pull vuls/vuls

docker run --rm -i \
    -v $PWD:/vuls \
    vuls/vuls report \
    -log-dir=/vuls/log \
    -format-list \
    -config=/vuls/config.toml \
    -refresh-cve \
    $@

