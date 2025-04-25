FROM quay.io/fedora/fedora-toolbox:41 AS davincibox

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

# rocm-opencl specifically depends on ocl-icd, which conflicts with OpenCL-ICD-Loader,
# which was pulled in by mesa-libOpenCL in the davinci-dependencies above
RUN dnf -y remove OpenCL-ICD-Loader
RUN dnf -y install intel-compute-runtime rocm-opencl
# Re-add mesa-libOpenCL here because removing OpenCL-ICD-Loader removes it,
# but re-installing mesa-libOpenCL doesn't pull OpenCL-ICD-Loader back in,
# so rusticl and ROCm can still co-exist
RUN dnf -y install mesa-libOpenCL
