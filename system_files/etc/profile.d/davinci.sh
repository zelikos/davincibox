#!/bin/bash

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
