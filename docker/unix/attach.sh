#!/bin/bash

CONTAINER_NAME=latex-srv

# Get Script PATH
PARENT_DIR=$(dirname $0 | sed "s#.*/##")
SCRIPT_DIR=$(dirname $(readlink -f $0) | sed "s#.*/##")
DOCKERFILE_DIR=$(dirname $(readlink -f $0) | sed "s/.$SCRIPT_DIR//")
SCRIPT_PATH=$DOCKERFILE_DIR/$SCRIPT_DIR

# Function to print an error message in red
function print_error() {
    echo -e "\033[31m[msg] $1 \033[m"
}

# Function to check if a service is running
function is_running() {
    service_name=$1
    if pgrep -x "$service_name" > /dev/null 2>&1; then
        return 0  # Service is running (success)
    else
        return 1  # Service is not running (failure)
    fi
}

# Function to check if a container is running
function is_container_running() {
    container_name=$1
    if [ -n "$($CONTAINER_SERVICE ps --filter "name=$container_name" --format "{{.ID}}")" ]; then
        return 0  # Container is running (success)
    else
        return 1  # Container is not running (failure)
    fi
}

# Check if Podman or Docker is running
if is_running "podman"; then
	CONTAINER_SERVICE=podman
elif is_running "dockerd"; then
	CONTAINER_SERVICE=docker
elif is_running "colima"; then
	CONTAINER_SERVICE=docker
else
    echo "Podman and Docker are not running."
    exit 1
fi

# Check if the container is running
if is_container_running $CONTAINER_NAME; then
    echo "[msg] $CONTAINER_NAME is already running. Attaching to it..."
    $CONTAINER_SERVICE attach $CONTAINER_NAME
    exit 0
else
    echo "[msg] Starting $CONTAINER_NAME Container"
    bash $SCRIPT_PATH/start.sh

    # Check if the container started successfully
    if is_container_running $CONTAINER_NAME; then
        echo "[msg] $CONTAINER_NAME started successfully. Attaching to it..."
        $CONTAINER_SERVICE attach $CONTAINER_NAME
        exit 0
    else
        print_error "Failed to start $CONTAINER_NAME Container."
        exit 1
    fi
fi