#!/bin/bash

docker pull vuls/vuls

if [[ $(tty) =~ "not a tty" ]]
then
    t=''
else
    t="-t"
fi

docker run --rm -i $t \
    -v $HOME/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    vuls/vuls configtest \
    -log-dir=/vuls/log \
    -config=/vuls/config.toml \
    $@ 
