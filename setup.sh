#!/bin/bash

container_type=""
container_create_prefix=""
container_run_prefix=""

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
        container_create_prefix="toolbox create -c davincibox"
        container_run_prefix="toolbox run --container davincibox"
    fi
else
    container_type="distrobox"
    echo "Distrobox found."
    container_create_prefix="distrobox create -n davincibox"
    container_run_prefix="distrobox enter davincibox --"
fi

if [[ $1 == "remove" ]]; then
    $container_run_prefix add-davinci-launcher remove

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

    $container_create_prefix -i ghcr.io/zelikos/davincibox:latest
    # Ensure packages are up-to-date in case of old container build
    $container_run_prefix sudo dnf -y update
    $container_run_prefix echo "davincibox initialized"

    # Check for installer file validity here instead of above,
    # because container can still be set up whether the file is valid or not.
    installer=$(readlink -e $1)
    if [[ -f $installer ]]; then
        # Extract DaVinci installer
        echo "Extracting ${installer} ..."
        $installer --appimage-extract
        if [[ $? -eq 0 ]]; then
          # Run setup-davinci
          extracted_installer="squashfs-root/AppRun"
          $container_run_prefix setup-davinci $extracted_installer $container_type
          rm -rf squashfs-root/
        else
            echo "${installer} could not be extracted."
            echo "Please double-check that it is a valid DaVinci Resolve installer."
            exit
        fi
    else
        echo "${1} is not a valid filename."
        echo "Re-run this script with a valid DaVinci Resolve installer."
        echo "e.g. ./setup.sh DaVinci_Resolve_18.5.1_Linux.run"
    fi
fi
