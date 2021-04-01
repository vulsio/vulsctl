#!/bin/bash

docker pull ishidaco/vulsrepo

docker run -dt \
    -v $PWD:/vuls \
    -p 5111:5111 \
    ishidaco/vulsrepo \
    $@
