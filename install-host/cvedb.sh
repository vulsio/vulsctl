#!/bin/sh

RELEASE=v0.13.1
URL=https://github.com/future-architect/vuls/releases/download/${RELEASE}/cve.sqlite3.gz 

if [ ! -e ./cve.sqlite3 ]; then
    echo "Fetching cve.sqlite3 from GitHub Vuls: ${URL}"
    curl -OL ${URL}
    gunzip ./cve.sqlite3.gz
fi

go-cve-dictionary fetch nvd $@

go-cve-dictionary fetch jvn $@
