#!/bin/bash

# Info for this line comes from here: https://www.reddit.com/r/voidlinux/comments/12g71x0/comment/l2cwo27/
# Slightly modified, as the original wasn't pointed to the correct lib file names
export LD_PRELOAD=/usr/lib64/libglib-2.0.so.0:/usr/lib64/libgdk_pixbuf-2.0.so.0:/usr/lib64/libgio-2.0.so.0:/usr/lib64/libgmodule-2.0.so>
export QT_QPA_PLATFORM=xcb

gpu_type=""

get_gpu_type () {
  if [[ -n $(glxinfo -B | grep -i nvidia) ]]; then
    gpu_type="nvidia"
  elif [[ -n $(glxinfo -B | grep -i AMD) ]]; then
    gpu_type="amd"
  elif [[ -n $(glxinfo -B | grep -i Intel) ]]; then
    gpu_type="intel"
  fi
}

use_rusticl () {
  export RUSTICL_ENABLE=radeonsi,iris,nouveau
  export OCL_ICD_VENDORS=rusticl.icd
}

get_gpu_type

# Default to rusticl on AMD GPUs
# Don't use rusticl if arg rocm is passed
# Allow use of arg rusticl to opt in for Intel and Nvidia nouveau users
if [[ $gpu_type == "amd" && $1 != "rocm" || $1 == "rusticl" ]]; then
  use_rusticl
fi
