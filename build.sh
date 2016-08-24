#!/usr/bin/env bash
#set -e

cd server
CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags "-w" -o server
cd ..
num=$(uname | sed 's/MINGW64_NT-\(.*\)/\1/')
if [[ "$num" ==  "6.1" ]]; then
    eval $(docker-machine env --shell=bash)
fi
docker-compose down -v
docker-compose build
docker-compose up -d