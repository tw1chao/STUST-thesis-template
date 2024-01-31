#!/bin/bash

IMAGE_NAME=stusthesis
CONTAINER_NAME=latex-srv

# Get Script PATH
PROJECT_DIR=$(cd $(dirname $0)/../..; pwd)
PARENT_DIR=$(dirname $0 | sed "s#.*/##")
SCRIPT_DIR=$(dirname $(readlink -f $0) | sed "s#.*/##")
DOCKERFILE_DIR=$(dirname $(readlink -f $0) | sed "s/.$SCRIPT_DIR//")
SCRIPT_PATH=$DOCKERFILE_DIR/$SCRIPT_DIR
USER=$(whoami)

# Function to check if a service is running
function is_running() {
    service_name=$1
    if pgrep -x "$service_name" > /dev/null 2>&1; then
        return 0  # Service is running (success)
    else
        return 1  # Service is not running (failure)
    fi
}

# Function to print an error message in red
function print_error() {
    echo -e "\033[31m[msg] $1 \033[m"
}

function container() {
    service_name=$1
    echo "Run container as $service_name"
    
    # Check if the image exists
    if ! $service_name images --format "{{.Repository}}:{{.Tag}}" | grep -q "^$IMAGE_NAME:latest$"; then
        print_error "Error: Image $IMAGE_NAME not found."
        exit 1
    fi

    # Build the base command
    cmd="$service_name run --privileged -it --rm --name $CONTAINER_NAME \
        --workdir /home/$USER/$IMAGE_NAME \
        --volume $PROJECT_DIR:/home/$USER/$IMAGE_NAME \
        -v /usr/share/zoneinfo:/usr/share/zoneinfo:ro \
        -v /etc/localtime:/etc/localtime:ro \
        --hostname $CONTAINER_NAME"

    # Conditionally add --userns=keep-id for podman
    if [ "$service_name" = "podman" ]; then
        cmd="$cmd --userns=keep-id"
    fi

    # Add the image name and run the command
    cmd="$cmd -d $IMAGE_NAME"
    eval "$cmd"
}

if is_running "podman"; then	# Check if Podman is running
	CONTAINER_SERVICE=podman 	# echo "Podman is running."
elif is_running "dockerd"; then	# Check if Docker is running
	CONTAINER_SERVICE=docker 	# echo "Docker is running."
elif is_running "colima"; then	# Check if Docker (either directly or via Colima) is running
	CONTAINER_SERVICE=docker 	# echo "Docker is running under Colima."
else
    print_error "Podman or Docker are not running."
    exit 1
fi

# Check if the container is already running
CONTAINER_ID=$($CONTAINER_SERVICE ps --filter "name=$CONTAINER_NAME" --format "{{.ID}}")

if [ -n "$CONTAINER_ID" ]; then
    echo "[msg] $CONTAINER_NAME is running!"
    exit 0
fi

# Check if the image exists before running the container
if ! $CONTAINER_SERVICE images --format "{{.Repository}}:{{.Tag}}" | grep -q "^$IMAGE_NAME:latest$"; then
    print_error "Image $IMAGE_NAME not found."
    exit 1
fi

# Run the container
container $CONTAINER_SERVICE
