#!/bin/bash

CONTAINER_NAME=latex-srv

# Get Script PATH
PARENT_DIR=$(dirname $0 | sed "s#.*/##")
SCRIPT_DIR=$(dirname $(readlink -f $0) | sed "s#.*/##")
DOCKERFILE_DIR=$(dirname $(readlink -f $0) | sed "s/.$SCRIPT_DIR//")
SCRIPT_PATH=$DOCKERFILE_DIR/$SCRIPT_DIR


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



CONTAINER_ID=`$CONTAINER_SERVICE ps | grep $CONTAINER_NAME`

echo -n ""

if [ -z "$CONTAINER_ID" ]; then
	echo -e "[msg] Starting $CONTAINER_NAME Container \n $(bash $SCRIPT_PATH/start.sh)"

	# attach_container
	$CONTAINER_SERVICE attach $CONTAINER_NAME

	exit 0

else
	# attach_container
	$CONTAINER_SERVICE attach $CONTAINER_NAME

fi

