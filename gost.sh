#!/bin/bash

docker run --rm -i \
    -v $PWD:/vuls \
    vuls/gost fetch redhat
