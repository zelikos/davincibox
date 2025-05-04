#!/bin/bash

container_type=""
container_create_prefix=""
container_run_prefix=""
davincibox_flavor=""
installer_path=""
nvidia_gpu=false
valid_installer=false

set_container_type () {
    container_manager=$1
    if [[ $container_manager == "toolbox" ]]; then
        echo "Toolbox found."
        container_type="toolbox"
        container_create_prefix="toolbox create -c davincibox"
        container_run_prefix="toolbox run --container davincibox"
    elif [[ $container_manager == "distrobox" ]]; then
        echo "Distrobox found."
        container_type="distrobox"
        container_create_prefix="distrobox create -n davincibox"
        container_run_prefix="distrobox enter davincibox --"
    fi
}

get_gpu_type () {
    if command -v lshw &> /dev/null; then
        if lshw -c video 2>/dev/null | grep -qi "driver=nvidia"; then
            echo "Nvidia GPU detected."
            nvidia_gpu=true
            davincibox_flavor="davincibox"
        else
          echo "No NVIDIA GPU detected. Using OpenCL"
          nvidia_gpu=false
          davincibox_flavor="davincibox-opencl"
        fi
    else
        echo "ERROR: lshw not found. Could not determine GPU vendor."
        echo "Install the lshw package to use setup.sh,"
        echo "or follow the manual setup instructions instead:"
        echo "https://github.com/zelikos/davincibox#manual"
        exit 1
    fi
}

check_davinci_installer () {
    installer=$1
    if [[ ! -f $installer ]]; then
        echo "$1 is not a valid filename."
        echo "Re-run this script with a valid DaVinci Resolve installer."
        echo "e.g. ./setup.sh DaVinci_Resolve_18.5.1_Linux.run"
        valid_installer=false
    else
        valid_installer=true
    fi
}

run_davinci_setup () {
    installer=$1
    # Extract DaVinci installer
    echo "Extracting ${installer} ..."
    $installer --appimage-extract
    if [[ $? -eq 0 ]]; then
      # Run setup-davinci
      extracted_installer="squashfs-root/AppRun"
      $container_run_prefix /usr/bin/setup-davinci $extracted_installer $container_type
      rm -rf squashfs-root/
    else
        echo "${installer} could not be extracted."
        echo "Please double-check that it is a valid DaVinci Resolve installer."
        exit
    fi
}

create_davincibox_container () {
    echo "Setting up $davincibox_flavor..."

    # Do this separately here to ensure the latest image is present
    # before the container is created.
    # See https://github.com/zelikos/davincibox/issues/26#issuecomment-1850642631
    podman image pull "ghcr.io/zelikos/$davincibox_flavor:latest"

    # Manual workaround for new NVIDIA flags because trying to construct
    # the command programmatically with variables caused quotation problems
    if [[ $container_type == distrobox && $nvidia_gpu == true ]]; then
      distrobox create -n davincibox --additional-flags "--gpus all" -i ghcr.io/zelikos/davincibox:latest
    else
      $container_create_prefix -i ghcr.io/zelikos/$davincibox_flavor:latest
    fi
    # Ensure packages are up-to-date in case of old container build
    $container_run_prefix sudo dnf -y update
    $container_run_prefix echo "davincibox initialized"
}

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
        set_container_type "toolbox"
        get_gpu_type
    fi
else
    set_container_type "distrobox"
    get_gpu_type
    # if [[ $nvidia_gpu == true ]]; then
    #     container_create_prefix+=" --additional-flags \"--gpus all\""
    #     echo "Container creation prefix: $container_create_prefix"
    # fi
fi

if [[ $1 == "remove" ]]; then
    $container_run_prefix /usr/bin/add-davinci-launcher remove

    echo "Removing DaVinci Resolve and davincibox..."
    remove_davincibox_container
elif [[ $1 == "upgrade" ]]; then
    echo "Removing davincibox container..."
    remove_davincibox_container

    echo "To complete the upgrade, re-run this setup script"
    echo "as you would for a fresh installation."
    echo "e.g. ./setup.sh DaVinci_Resolve_18.5.1_Linux.run"
else
    installer_path=$(readlink -e $1)
    # Create davincibox container on user's system
    create_davincibox_container
    # Check that provided installer path is valid
    check_davinci_installer $installer_path
    if [[ $valid_installer == true ]]; then
        run_davinci_setup $installer_path
    fi
fi
