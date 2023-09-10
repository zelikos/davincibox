FROM registry.fedoraproject.org/fedora-toolbox:38 AS davincibox

# Support Nvidia Container Runtime (https://developer.nvidia.com/nvidia-container-runtime)
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox commands" \
      summary="Dependencies for running DaVinci Resolve on image-based Linux operating systems" \
      maintainer="pcsikos@zelikos.dev"

RUN dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
RUN dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

COPY extra-packages /
RUN dnf -y update && \
    grep -v '^#' /extra-packages | xargs dnf -y install
RUN rm /extra-packages
