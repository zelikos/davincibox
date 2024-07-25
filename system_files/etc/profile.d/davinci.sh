#!/bin/bash

# Info for this line comes from here: https://www.reddit.com/r/voidlinux/comments/12g71x0/comment/l2cwo27/
# Slightly modified, as the original wasn't pointed to the correct lib file names
export LD_PRELOAD=/usr/lib64/libglib-2.0.so.0:/usr/lib64/libgdk_pixbuf-2.0.so.0:/usr/lib64/libgio-2.0.so.0:/usr/lib64/libgmodule-2.0.so.0
export QT_QPA_PLATFORM=xcb

gpu_type=""

get_gpu_type () {
  if lshw -c video 2>/dev/null | grep -qi nvidia; then
    gpu_type="nvidia"
  elif lshw -c video 2>/dev/null | grep -qi amd; then
    gpu_type="amd"
  elif lshw -c video 2>/dev/null | grep -qi intel; then
    gpu_type="intel"
  fi
}

use_rusticl () {
  export RUSTICL_ENABLE=radeonsi,iris,nouveau
  export OCL_ICD_VENDORS=rusticl.icd
}

get_gpu_type

# Default to rusticl on AMD GPUs
if [[ $gpu_type == "amd" ]]; then
  use_rusticl
fi
