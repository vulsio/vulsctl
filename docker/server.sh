#!/bin/sh

docker pull vuls/vuls

docker run --rm -it\
    -v $HOME/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    vuls/vuls configtest \
    -log-dir=/vuls/docker/log \
    -config=/vuls/config.toml \
    $@

ret=$?
if [ $ret -ne 0 ]; then
	exit 1
fi

docker run --rm -it\
    -v $HOME/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    -p 5515:5515 \
    vuls/vuls server \
    -listen=0.0.0.0:5515 \
    -cvedb-sqlite3-path=/vuls/docker/cve.sqlite3 \
    -ovaldb-sqlite3-path=/vuls/docker/oval.sqlite3 \
    -gostdb-sqlite3-path=/vuls/docker/gost.sqlite3 \
    -exploitdb-sqlite3-path=/vuls/docker/go-exploitdb.sqlite3 \
    -msfdb-sqlite3-path=/vuls/docker/go-msfdb.sqlite3 \
    -results-dir=/vuls/results \
    -log-dir=/vuls/docker/log \
    -config=/vuls/config.toml \
    -to-localfile \
    -format-json \
    $@
