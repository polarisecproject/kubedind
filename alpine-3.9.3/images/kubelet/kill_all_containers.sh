#! /bin/sh

docker ps | grep -v  “^CONTAINER” | cut -f 1 -d " " | xargs docker kill 
docker ps -a | grep -v  “^CONTAINER” | cut -f 1 -d " " | xargs docker rm -v
