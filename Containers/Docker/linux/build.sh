#!/bin/bash

PROJECT_DIR=$(dirname $0)
docker build -t stusthesis:latest \
	--build-arg USER=`whoami` \
	--build-arg USERID=`id -u` \
	--build-arg GROUPID=`id -g` $PROJECT_DIR/../../.
