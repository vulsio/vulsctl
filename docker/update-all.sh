#!/bin/bash

./oval.sh --redhat ${@}
./oval.sh --amazon ${@}
./oval.sh --debian ${@}
./oval.sh --ubuntu ${@}
./oval.sh --alpine ${@}
./oval.sh --oracle ${@}
./oval.sh --fedora ${@}
./oval.sh --suse   ${@}
./gost.sh --redhat ${@}
./gost.sh --debian ${@}
./gost.sh --ubuntu ${@}
./nvd.sh ${@}
./jvn.sh ${@}
./exploitdb.sh ${@}
./msfdb.sh ${@}
./kev.sh ${@}
