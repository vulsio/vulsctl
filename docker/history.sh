#!/bin/sh

docker pull vuls/vuls

docker run --rm -i \
    -v $PWD:/vuls \
    vuls/vuls history \
    -results-dir=/vuls/results \
    $@
