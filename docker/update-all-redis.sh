#!/bin/bash

export DOCKER_NETWORK=redis-nw
redis_host='redis'
redis_url="redis://${redis_host}"

./oval.sh --redhat --dbtype redis --dbpath ${redis_url}/1 ${@} 
./oval.sh --amazon --dbtype redis --dbpath ${redis_url}/1 ${@}
./oval.sh --debian --dbtype redis --dbpath ${redis_url}/1 ${@} 
./oval.sh --ubuntu --dbtype redis --dbpath ${redis_url}/1 ${@} 
./oval.sh --alpine --dbtype redis --dbpath ${redis_url}/1 ${@}
./oval.sh --oracle --dbtype redis --dbpath ${redis_url}/1 ${@}
./gost.sh --redhat --dbtype redis --dbpath ${redis_url}/2 ${@} 
./gost.sh --debian --dbtype redis --dbpath ${redis_url}/2 ${@} 
./gost.sh --ubuntu --dbtype redis --dbpath ${redis_url}/2 ${@} 
./nvd.sh --dbtype redis --dbpath ${redis_url}/3 ${@} 
./jvn.sh --dbtype redis --dbpath ${redis_url}/3 ${@} 
./exploitdb.sh --dbtype redis --dbpath ${redis_url}/4 ${@}
./msfdb.sh --dbtype redis --dbpath ${redis_url}/5 ${@} 
./kev.sh --dbtype redis --dbpath ${redis_url}/6 ${@} 
