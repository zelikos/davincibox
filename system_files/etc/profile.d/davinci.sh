#!/bin/bash

export QT_QPA_PLATFORM=xcb
export QT_AUTO_SCREEN_SCALE_FACTOR=1

gpu_type=""

get_gpu_type () {
  # Checks only for nvidia driver and not nouveau
  if lshw -c video 2>/dev/null | grep -qi "driver=nvidia"; then
    gpu_type="nvidia"
  # Checks for amdgpu so that we can specify using rusticl by default
  elif lshw -c video 2>/dev/null | grep -qi "driver=amdgpu"; then
    gpu_type="amd"
  # We don't have any special handling necessary for Intel GPUs at this time,
  # so we aren't currently checking for them.
  # In case we need to in the future, the Intel drivers are:
  # - driver=i915
  # - driver=xe
  fi
}

get_gpu_type
