#!/bin/bash

if [ $# -ne 1 ]; then
  echo "specify [redhat debian] as cmd arg"
  exit 1
fi

if [ $1 = "redhat" ]; then
    docker run --rm -i \
        -v $PWD:/vuls \
        vuls/gost fetch redhat
fi

if [ $1 = "debian" ]; then
    docker run --rm -i \
        -v $PWD:/vuls \
        vuls/gost fetch debian
fi
