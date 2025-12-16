#!/bin/bash
set -e

# Load configuration from .env file
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "Warning: .env file not found. Using defaults from .env.example"
    export $(cat .env.example | grep -v '^#' | xargs)
fi

# Get git hash
GIT_HASH=$(git rev-parse --short HEAD)

# Extract version from RAY_BASE_VERSION (e.g., 2.52.1-gpu -> 2.52.1-gpu)
VERSION_TAG="${RAY_BASE_VERSION}-${GIT_HASH}"

echo "Building ${IMAGE_NAME}:${VERSION_TAG}"
echo "Base image: rayproject/ray:${RAY_BASE_VERSION}"

# Build the Docker image
docker build \
    --build-arg RAY_BASE_VERSION="${RAY_BASE_VERSION}" \
    -t "${IMAGE_NAME}:${VERSION_TAG}" \
    -t "${IMAGE_NAME}:latest" \
    .

echo "Successfully built ${IMAGE_NAME}:${VERSION_TAG}"
echo "Also tagged as ${IMAGE_NAME}:latest"
