#!/bin/sh

./oval.sh --redhat && \
./oval.sh --amazon && \
./oval.sh --debian && \
./oval.sh --ubuntu && \
./oval.sh --alpine && \
./oval.sh --oracle && \
./oval.sh --fedora && \
./oval.sh --suse && \
./gost.sh --redhat && \
./gost.sh --debian && \
./gost.sh --ubuntu && \
./gost.sh --microsoft && \
./cvedb.sh --nvd && \
./cvedb.sh --jvn && \
./cvedb.sh --fortinet && \
./cvedb.sh --mitre && \
./cvedb.sh --paloalto && \
./cvedb.sh --cisco && \
./exploitdb.sh && \
./msfdb.sh && \
./kev.sh && \
./cti.sh