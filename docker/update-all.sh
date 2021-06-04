#!/bin/bash

./oval.sh --redhat ${@} 
./oval.sh --amazon ${@} 
./oval.sh --debian ${@} 
./oval.sh --ubuntu ${@} 
./oval.sh --alpine ${@} 
./oval.sh --oracle ${@} 
./gost.sh --redhat ${@} 
./gost.sh --debian ${@} 
./nvd.sh ${@} 
./exploitdb.sh ${@} 
./msfdb.sh ${@} 
