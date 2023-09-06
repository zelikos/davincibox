#!/bin/bash

use_distrobox=false

# Check that argument containing DaVinci_Resolve_version_LInux.run was provided
if [[ $1 ]]
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
            echo "Toolbox found."
            # TODO: Add Toolbox support
            echo "Toolbox support is currently WIP. Please use distrobox for now."
            exit
        fi
    else
        use_distrobox=true
        echo "Distrobox found."
    fi
else
    echo "Please provide path to DaVinci Resolve installer file."
    echo "e.g. ./setup.sh /path/to/folder/DaVinci_Resolve_18.1.4_linux.run"
    exit
fi

# Create davincibox on user's system
echo "Setting up davincibox..."

if $use_distrobox
then
    distrobox create -i ghcr.io/zelikos/davincibox:latest -n davincibox
    # Start up the container now after creation,
    # rather than during the later steps
    distrobox enter davincibox -- echo "davincibox initialized"
else
    toolbox create -i ghcr.io/zelikos/davincibox:latest -c davincibox
fi

# Extract DaVinci Resolve installer
$1 --appimage-extract
if [ $? -eq 0 ]
then
    if $use_distrobox
    then
        distrobox enter davincibox -- sudo squashfs-root/AppRun -i -a -y
        # Workaround for an issue with Resolve's included libglib-2.0
        # May not be needed in the future
        distrobox enter davincibox -- sudo rm /opt/resolve/libs/libglib-2.0.so /opt/resolve/libs/libglib-2.0.so.0 /opt/resolve/libs/libglib-2.0.so.0.6800.4
    # TODO: Add toolbox support
    fi
else
    echo "${1} is not a DaVinci Resolve installer."
    exit
fi

# Cleanup
rm -rf squashfs-root/

# Prompt user about adding desktop launcher
add_launcher=false

echo "Add DaVinci Resolve launcher? y/N"
read response
case "$response" in
    "y")    add_launcher=true;;
    "Y")    add_launcher=true;;
    *)      add_launcher=false;;
esac

if $add_launcher
then
    if $use_distrobox
    then
        distrobox enter davincibox -- distrobox-export --app /opt/resolve/bin/resolve
    # TODO: Toolbox support
    fi
else
    echo "If you would like to create a launcher later,"
    if $use_distrobox
    then
        echo "run the following command:"
        echo "distrobox enter davincibox -- distrobox-export --app /opt/resolve/bin/resolve"
    # TODO: Toolbox
    fi
    echo ""
    echo "Otherwise, to run DaVinci Resolve from the CLI, use:"
    echo "distrobox enter davincibox -- /opt/resolve/bin/resolve"
fi
