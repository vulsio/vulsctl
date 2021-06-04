#!/bin/bash

export DOCKER_NETWORK=redis-nw
redis_host='redis'
redis_url="redis://${redis_host}"

./oval.sh --redhat --dbtype redis --dbpath ${redis_url}/1 --debug ${@} 
./oval.sh --amazon --dbtype redis --dbpath ${redis_url}/1 --debug ${@}
./oval.sh --debian --dbtype redis --dbpath ${redis_url}/1 --debug ${@} 
./oval.sh --ubuntu --dbtype redis --dbpath ${redis_url}/1 --debug ${@} 
./oval.sh --alpine --dbtype redis --dbpath ${redis_url}/1 --debug ${@}
./oval.sh --oracle --dbtype redis --dbpath ${redis_url}/1 --debug ${@}
./gost.sh --redhat --dbtype redis --dbpath ${redis_url}/2 --debug ${@} 
./gost.sh --debian --dbtype redis --dbpath ${redis_url}/2 --debug ${@} 
./nvd.sh --dbtype redis --dbpath ${redis_url}/3 --debug ${@} 
./exploitdb.sh --dbtype redis --dbpath ${redis_url}/4 --debug ${@}
./msfdb.sh --dbtype redis --dbpath ${redis_url}/5 --debug ${@} 
