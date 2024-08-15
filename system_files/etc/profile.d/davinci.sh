#!/bin/bash

export QT_QPA_PLATFORM=xcb

gpu_type=""

get_gpu_type () {
  # Checks only for nvidia driver and not nouveau, as nouveau is handled differently than the proprietary driver
  if lshw -c video 2>/dev/null | grep -qi "driver=nvidia"; then
    gpu_type="nvidia"
  # Checks for amdgpu and not radeon, as any GPUs that outright require the radeon driver
  # are *very* unlikely to handle running DaVinci Resolve anyway
  elif lshw -c video 2>/dev/null | grep -qi "driver=amdgpu"; then
    gpu_type="amd"
  # TODO: Check for Intel driver name(s) instead
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
