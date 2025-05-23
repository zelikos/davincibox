FROM quay.io/fedora/fedora-toolbox:42 AS davincibox

# Support Nvidia Container Runtime (https://developer.nvidia.com/nvidia-container-runtime)
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

LABEL com.github.containers.toolbox="true" \
    usage="This image is meant to be used with the toolbox or distrobox commands" \
    summary="Dependencies for running DaVinci Resolve on image-based Linux operating systems" \
    maintainer="pcsikos@zelikos.dev"

COPY system_files /

COPY davinci-dependencies /
RUN dnf -y update && \
    grep -v '^#' /davinci-dependencies | xargs dnf -y install
RUN rm /davinci-dependencies

FROM davincibox AS davincibox-opencl

# Ensure ocl-icd is installed, as OpenCL-ICD-Loader tends to be pulled in
# as a dependency but does not work. See:
# https://github.com/zelikos/davincibox/issues/158
# https://github.com/zelikos/davincibox/issues/169
RUN dnf -y install --allowerasing ocl-icd
RUN dnf -y install intel-compute-runtime rocm-opencl
