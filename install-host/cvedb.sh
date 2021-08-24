#!/bin/sh

RELEASE=v0.13.1
URL=https://github.com/future-architect/vuls/releases/download/${RELEASE}/cve.sqlite3.gz 

if [ ! -e ./cve.sqlite3 ]; then
    echo "Fetching cve.sqlite3 from GitHub Vuls: ${URL}"
    curl -OL ${URL}
    gunzip ./cve.sqlite3.gz
fi

for i in `seq 2002 $(date +"%Y")`; do \
    go-cve-dictionary fetch nvd $@ --years $i; \
done

for i in `seq 1998 $(date +"%Y")`; do \
    go-cve-dictionary fetch jvn $@ --years $i; \
done
