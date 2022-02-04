#!/bin/sh

./oval.sh --redhat && \
./oval.sh --amazon && \
./oval.sh --debian && \
./oval.sh --ubuntu && \
./oval.sh --alpine && \
./oval.sh --oracle && \
./oval.sh --fedora && \
./gost.sh --redhat && \
./gost.sh --debian && \
./gost.sh --ubuntu && \
./cvedb.sh && \
./exploitdb.sh && \
./msfdb.sh
./kev.sh