#!/bin/bash

CONTAINER_NAME=latex-srv

# Function to check if a service is running
function is_running() {
    service_name=$1
    if pgrep -x "$service_name" > /dev/null 2>&1; then
        return 0  # Service is running (success)
    else
        return 1  # Service is not running (failure)
    fi
}

if is_running "podman"; then	# Check if Podman is running
	CONTAINER_SERVICE=podman 	# echo "Podman is running."
elif is_running "dockerd"; then	# Check if Docker is running
	CONTAINER_SERVICE=docker 	# echo "Docker is running."
elif is_running "colima"; then	# Check if Docker (either directly or via Colima) is running
	CONTAINER_SERVICE=docker 	# echo "Docker is running under Colima."
else
    echo "Podman or Docker are not running."
	exit 1
fi


function stopping_container(){
    service_name=$1

    echo -n "$service_name $CONTAINER_NAME container stopping"
    $service_name stop $CONTAINER_NAME

}

CONTAINER_ID=`$CONTAINER_SERVICE ps | grep $CONTAINER_NAME`

if [ "$1" = "all" ]; then
    echo "[msg] $CONTAINER_SERVICE stop and remove all container!"
    $CONTAINER_SERVICE stop $($CONTAINER_SERVICE ps -a -q) > /dev/null 2>&1
    $CONTAINER_SERVICE rm $($CONTAINER_SERVICE ps -a -q) > /dev/null 2>&1
elif [ -z "$CONTAINER_ID" ]; then
    echo "[msg] $CONTAINER_NAME not running!"
    exit 0
else
	stopping_container $CONTAINER_SERVICE
fi