#!/bin/bash

# TODOs

# Check that argument containing DaVinci_Resolve_version_LInux.run was provided
# Check if distrobox is installed
# If no distrobox, check for toolbox
# If neither are installed, inform the user that one of them is needed and exit

# Create davincibox on user's system

# Run DaVinci_Resolve_version_Linux.run --appimage-extract
# Run sudo squashfs-root/AppRun -i -a -y from davincibox

# Run sudo rm /opt/resolve/libs/libglib-2.0.* from davincibox

# If using distrobox, run distrobox-export --app /opt/resolve/bin/resolve from davincibox
# Else, do toolbox steps