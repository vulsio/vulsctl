#!/bin/bash

docker pull vuls/go-msfdb

docker run --rm -it \
    -v $PWD:/vuls \
    vuls/go-msfdb fetch msfdb
