#!/bin/bash

docker pull ishidaco/vulsrepo

if [[ $(tty) =~ "not a tty" ]]
then
    t=''
else
    t="-t"
fi

docker run -d $t \
    -v $PWD:/vuls \
    -p 5111:5111 \
    ishidaco/vulsrepo \
    $@
