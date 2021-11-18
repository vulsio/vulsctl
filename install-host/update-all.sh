#!/bin/sh

./oval.sh --redhat && \
./oval.sh --amazon && \
./oval.sh --debian && \
./oval.sh --ubuntu && \
./oval.sh --alpine && \
./oval.sh --oracle && \
./gost.sh --redhat --batch-size 500&& \
./gost.sh --debian --batch-size 500 && \
./gost.sh --ubuntu --batch-size 15 && \
./cvedb.sh && \
./exploitdb.sh && \
./msfdb.sh
./kev.sh