#!/bin/bash

docker pull vuls/vuls

if [[ $(tty) =~ "not a tty" ]]
then
    t=''
else
    t="-t"
fi

docker run --rm -i $t\
    -v $PWD:/vuls \
    vuls/vuls tui $@ \
    -log-dir=/vuls/log \
    -config=/vuls/config.toml\
    -refresh-cve \
    $@

