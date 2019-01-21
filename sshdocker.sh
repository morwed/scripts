#!/bin/sh

set -xe

hash=$(docker ps -q -f name=$1)
echo "hash for '$1' is '$hash'"
docker exec -i -t $hash /bin/sh
