#!/bin/sh

hash=$(docker ps | awk -v img=$1 '/img/ {print $1}')
echo $hash
docker exec -i -t $hash /bin/sh