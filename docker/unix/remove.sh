#!/bin/bash

IMAGE_NAME=stusthesis

# Function to check if a service is running
function is_running() {
    service_name=$1
    if pgrep -x "$service_name" > /dev/null 2>&1; then
        return 0  # Service is running (success)
    else
        return 1  # Service is not running (failure)
    fi
}

# Check if Podman is running
if is_running "podman"; then
	CONTAINER_SERVICE=podman # echo "Podman is running."
# Check if Docker (either directly or via Colima) is running
elif is_running "dockerd"; then
	CONTAINER_SERVICE=docker # echo "Docker is running."
elif is_running "colima"; then
	CONTAINER_SERVICE=docker # echo "Docker is running under Colima."
else
  echo "Podman and Docker is not running."
  exit 1
fi

IMAGE_ID=$($CONTAINER_SERVICE images --filter reference=$IMAGE_NAME --format "{{.ID}}")
SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

function remove_image(){
  echo $(bash $SCRIPT_PATH/stop.sh)
  $CONTAINER_SERVICE rm $IMAGE_ID > /dev/null 2>&1
  $CONTAINER_SERVICE rmi $IMAGE_ID > /dev/null 2>&1

  # Run docker system prune and capture the output
  output=$($CONTAINER_SERVICE system prune -f)

  # Extract the "Total reclaimed space" line
  reclaimed_space=$(echo "$output" | grep "Total reclaimed space" | awk -F': ' '{print $2}')

  # Print the extracted value
  echo "Total reclaimed space: $reclaimed_space"

}

function clear_cache(){
  $CONTAINER_SERVICE container prune -f
  $CONTAINER_SERVICE volume prune -f
  $CONTAINER_SERVICE network prune -f
  # $CONTAINER_SERVICE image prune -a -f
}

function prompt_confirm(){ 
  case $input in
    [yY][eE][sS]|[yY])
    echo "OK, We'll Remove Image"
    remove_image
    exit;;

    [nN][oO]|[nN])
    echo -e "\033[32m Image Will be Save \033[m"
    exit 0;;

    *)
    echo -e "\033[31m\033[1m INVALID INPUT \033[m"
    exit 1;;

  esac
}


if [ -n "$IMAGE_ID" ]; then
    echo The Image name is $IMAGE_NAME, and the image-ID is $IMAGE_ID.
    read -r -p "$(echo -e "\033[31m\033[1m Are You Sure Remove Image? [Y/n] \033[m")" input
    prompt_confirm
else
    echo "Image not found."
fi

