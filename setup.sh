#!/bin/bash

container_type=""

# Check that argument containing DaVinci_Resolve_version_LInux.run was provided
if [[ -f $(readlink -e $1) ]]
then
    # Check if distrobox is installed
    if ! command -v distrobox &> /dev/null
    then
        # If no distrobox, check for toolbox
        echo "Distrobox not found. Checking for toolbox..."
        if ! command -v toolbox &> /dev/null
        then
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
else
    echo "Please provide path to DaVinci Resolve installer file."
    echo "e.g. ./setup.sh /path/to/folder/DaVinci_Resolve_18.1.4_linux.run"
    exit
fi

# Create davincibox on user's system
echo "Setting up davincibox..."

if [[ $container_type == "distrobox" ]]
then
    distrobox create -i ghcr.io/zelikos/davincibox:latest -n davincibox
    # Start up the container now after creation,
    # rather than during the later steps
    distrobox enter davincibox -- echo "davincibox initialized"
else
    toolbox create -i ghcr.io/zelikos/davincibox:latest -c davincibox
    toolbox run --container davincibox echo "davincibox initialized"
fi

# Run setup-davinci
if [[ $container_type == "distrobox" ]]
then
    distrobox enter davincibox -- setup-davinci $1 $container_type
else
    toolbox run --container davincibox setup-davinci $1 $container_type
fi
