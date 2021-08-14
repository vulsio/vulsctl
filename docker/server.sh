#!/bin/sh

docker pull vuls/vuls

docker run --rm -it \
    -v $HOME/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    vuls/vuls configtest \
    -log-dir=/vuls/log \
    -config=/vuls/config.toml \
    $@

ret=$?
if [ $ret -ne 0 ]; then
	exit 1
fi

docker run --rm -dt \
    -v $HOME/.ssh:/root/.ssh:ro \
    -v $PWD:/vuls \
    -p 5515:5515 \
    vuls/vuls server \
    -listen=0.0.0.0:5515 \
    -results-dir=/vuls/results \
    -log-dir=/vuls/log \
    -config=/vuls/config.toml \
    -to-localfile \
    $@
