#!/bin/bash

container_type=""

remove_davincibox_container () {
    podman container stop davincibox
    podman container rm davincibox

    echo "davincibox removed."
}

# Check if distrobox is installed
if ! command -v distrobox &> /dev/null; then
    # If no distrobox, check for toolbox
    echo "Distrobox not found. Checking for toolbox..."
    if ! command -v toolbox &> /dev/null; then
        echo "Toolbox not found."
        # If neither are installed, inform the user, then exit
        echo "Please install either distrobox or toolbox to use this script."
        exit
    else
        container_type="toolbox"
        echo "Toolbox found."
    fi
else
    container_type="distrobox"
    echo "Distrobox found."
fi


if [[ $1 == "remove" ]]; then
    if [[ $container_type == "distrobox" ]]; then
        distrobox enter davincibox -- add-davinci-launcher remove
    elif [[ $container_type == "toolbox" ]]; then
        toolbox run --container davincibox add-davinci-launcher remove
    fi

    echo "Removing DaVinci Resolve and davincibox..."
    remove_davincibox_container
elif [[ $1 == "upgrade" ]]; then
    echo "Removing davincibox container..."
    remove_davincibox_container

    echo "To complete the upgrade, re-run this setup script"
    echo "as you would for a fresh installation."
    echo "e.g. ./setup.sh DaVinci_Resolve_18.5.1_Linux.run"
else
    # Create davincibox on user's system
    echo "Setting up davincibox..."

    # Do this separately here to ensure the latest image is present
    # before the container is created.
    # See https://github.com/zelikos/davincibox/issues/26#issuecomment-1850642631
    podman image pull ghcr.io/zelikos/davincibox:latest

    if [[ $container_type == "distrobox" ]]; then
        distrobox create -i ghcr.io/zelikos/davincibox:latest -n davincibox
        # Start up the container now after creation,
        # rather than during the later steps
        distrobox enter davincibox -- echo "davincibox initialized"
    else
        toolbox create -i ghcr.io/zelikos/davincibox:latest -c davincibox
        toolbox run --container davincibox echo "davincibox initialized"
    fi

    # Check for installer file validity here instead of above,
    # because container can still be set up whether the file is valid or not.
    if [[ -f $(readlink -e $1) ]]; then
        # Run setup-davinci
        if [[ $container_type == "distrobox" ]]; then
            distrobox enter davincibox -- setup-davinci $1 $container_type
        else
            toolbox run --container davincibox setup-davinci $1 $container_type
        fi
    else
        echo "${1} is not a valid filename."
        echo "Re-run this script with a valid DaVinci Resolve installer."
        echo "e.g. ./setup.sh DaVinci_Resolve_18.5.1_Linux.run"
    fi
fi
