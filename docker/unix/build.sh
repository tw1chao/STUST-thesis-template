#!/bin/bash

# Setup NAME to image and container
IMAGE_NAME=stusthesis
CONTAINER_NAME="latex-srv"

# Get Script PATH
PARENT_DIR=$(dirname $0 | sed "s#.*/##")
SCRIPT_DIR=$(dirname $(readlink -f $0) | sed "s#.*/##")
DOCKERFILE_DIR=$(dirname $(readlink -f $0) | sed "s/.$SCRIPT_DIR//")
SCRIPT_PATH=$DOCKERFILE_DIR/$SCRIPT_DIR

OS=$(uname)
USER=$(whoami)
USERID=$(id -u)   # UID
GROUPID=$(id -g)  # GID

# Function to check if a service is running
function is_running() {
    service_name=$1
    if pgrep -x "$service_name" > /dev/null 2>&1; then
        return 0  # Service is running (success)
    else
        return 1  # Service is not running (failure)
    fi
}

# Function to replace script variables
function replace_name() {
    echo "Replace Script variable"

    # Replace IMAGE_NAME and CONTAINER_NAME in one pass
    for FILE in start.sh remove.sh stop.sh attach.sh; do
        if [[ "$OS" == "Darwin" ]]; then
            # macOS uses -i '' for in-place editing
            sed -i '' -e "s/IMAGE_NAME=.*/IMAGE_NAME=$IMAGE_NAME/g" \
                      -e "s/CONTAINER_NAME=.*/CONTAINER_NAME=$CONTAINER_NAME/g" \
                    "$SCRIPT_PATH/$FILE"
        else
            # Linux uses -i for in-place editing
            sed -i  -e "s/IMAGE_NAME=.*/IMAGE_NAME=$IMAGE_NAME/g" \
                    -e "s/CONTAINER_NAME=.*/CONTAINER_NAME=$CONTAINER_NAME/g" \
                    "$SCRIPT_PATH/$FILE"
        fi
    done

}


function container(){
    service_name=$1
    DOCKER_BUILDKIT=1
    echo "Run container as $service_name"

    echo "Use $service_name service."

    # Build the base command
    cmd="$service_name image build --no-cache \
        -t $IMAGE_NAME:latest \
        --build-arg USER=$USER \
        --build-arg USERID=$USERID \
        --build-arg GROUPID=$GROUPID \
        --build-arg PROJECT=$IMAGE_NAME"

    # Conditionally add Dockerfile for podman
    if [ "$service_name" = "podman" ]; then
        cmd="$cmd -f $DOCKERFILE_DIR/Dockerfile"
    else
        cmd="$cmd $DOCKERFILE_DIR/. "
    fi

    eval "$cmd"

    # Run docker system prune and capture the output
    output=$(docker system prune -f)

    # Extract the "Total reclaimed space" line
    reclaimed_space=$(echo "$output" | grep "Total reclaimed space" | awk -F': ' '{print $2}')

    # Print the extracted value
    echo "Total reclaimed space: $reclaimed_space"
}


if is_running "podman"; then    # Check if Podman is running
	CONTAINER_SERVICE=podman    # echo "Podman is running."
elif is_running "dockerd"; then	# Check if Docker is running
	CONTAINER_SERVICE=docker    # echo "Docker is running."
elif is_running "colima"; then	# Check if Docker (either directly or via Colima) is running
	CONTAINER_SERVICE=docker    # echo "Docker is running under Colima."
else
  echo "Podman or Docker are not running."
	exit 1
fi

# Call the replace_name function based on OS
if [[ "$OS" == "Linux" || "$OS" == "Darwin" ]]; then
    replace_name
else
    echo "Unknown Operating System"
fi


container $CONTAINER_SERVICE