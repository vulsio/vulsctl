#!/bin/bash

docker pull vuls/vuls

SELF=$$
ls /proc/$SELF/fd/0 -l | grep /dev/pts > /dev/null
if [ $? -eq 0 ]; then
        echo "input device is TTY device"
        T=-t
else
        echo "input device is non TTY"
        T=
fi

docker run --rm -i $T \
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

docker run --rm -d $T \
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
