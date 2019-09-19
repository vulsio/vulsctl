#!/bin/sh

docker pull vuls/go-cve-dictionary

RELEASE=v0.9.0
URL=https://github.com/future-architect/vuls/releases/download/${RELEASE}/cve.sqlite3.gz 

if [ ! -e ./cve.sqlite3 ]; then
    echo "Fetching cve.sqlite3 from GitHub Vuls: ${URL}"
    curl -OL ${URL}
    gunzip ./cve.sqlite3.gz
fi

for i in `seq 2002 $(date +"%Y")`; do \
    docker run --rm -it \
    -v $PWD:/vuls \
    vuls/go-cve-dictionary fetchnvd -years $i; \
done

for i in `seq 1998 $(date +"%Y")`; do \
    docker run --rm -it \
    -v $PWD:/vuls \
    vuls/go-cve-dictionary fetchjvn -years $i; \
done
