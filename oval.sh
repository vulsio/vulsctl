#!/bin/sh


if [ $# -ne 1 ]; then
  echo "specify [redhat amazon debian ubuntu alpine] as cmd arg"
  exit 1
fi

if [ $1 = "redhat" ]; then
    docker run --rm -it \
        -v $PWD:/vuls \
        vuls/goval-dictionary fetch-redhat 6 7 8
fi

if [ $1 = "amazon" ]; then
    docker run --rm -it \
        -v $PWD:/vuls \
        vuls/goval-dictionary fetch-amazon
fi

if [ $1 = "debian" ]; then
    docker run --rm -it \
        -v $PWD:/vuls \
        vuls/goval-dictionary fetch-debian 8 9 10
fi

if [ $1 = "ubuntu" ]; then
    docker run --rm -it \
        -v $PWD:/vuls \
        vuls/goval-dictionary fetch-ubuntu 16 18 
fi

if [ $1 = "alpine" ]; then
    docker run --rm -it \
        -v $PWD:/vuls \
        vuls/goval-dictionary fetch-alpine 3.3 3.4 3.5 3.6 3.7 3.8 3.9 3.10
fi

