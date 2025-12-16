# Configurable Ray Base Image
# Build with: docker build --build-arg RAY_BASE_VERSION=2.52.1-gpu -t ray-baseimage .

ARG RAY_BASE_VERSION=2.52.1-gpu

FROM rayproject/ray:${RAY_BASE_VERSION}

# Add any custom configurations or installations here
# Example:
RUN sudo apt-get update \
    && sudo apt-get -y install libgl1-mesa-glx libgl1-mesa-dri libglib2.0-0 \
    && sudo apt-get -y clean autoclean \
    && sudo apt-get -y autoremove \
    && sudo rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && pip install ultralytics 

# Set working directory
WORKDIR /app

# Default command
CMD ["bash"]

