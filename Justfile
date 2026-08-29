build:
    podman build --target "davincibox" -t "davincibox:latest" .

build-opencl:
    podman build --target "davincibox-opencl" -t "davincibox-opencl:latest" .
