# Ray Base Image

A configurable Docker image based on [Ray](https://www.ray.io/) with automated builds via GitHub Actions.

## Overview

This project builds a Docker image from a configurable Ray base image (default: `rayproject/ray:2.52.1-gpu`) and automatically tags it with the git commit hash for version tracking.

## Configuration

The base Ray version can be configured in two ways:

### Local Builds

1. Copy the example configuration:
   ```bash
   cp .env.example .env
   ```

2. Edit `.env` to set your desired Ray version:
   ```bash
   RAY_BASE_VERSION=2.52.1-gpu
   ```

### GitHub Actions

Edit the `RAY_BASE_VERSION` environment variable in `.github/workflows/docker-build.yml`:

```yaml
env:
  RAY_BASE_VERSION: 2.52.1-gpu
```

## Local Build

1. Ensure you have Docker installed and running

2. Make the build script executable:
   ```bash
   chmod +x build.sh
   ```

3. Run the build script:
   ```bash
   ./build.sh
   ```

This will build the image and tag it as:
- `ray-baseimage:<version>-<git-hash>`
- `ray-baseimage:latest`

## GitHub Actions

The project includes a GitHub Actions workflow that automatically:

1. Triggers on pushes to the `main` branch
2. Builds the Docker image with the configured Ray base version
3. Tags the image with `<version>-<git-hash>` and `latest`
4. Pushes to GitHub Container Registry (ghcr.io)

### Setup

The workflow uses the `GITHUB_TOKEN` automatically provided by GitHub Actions. No additional secrets are required.

### Image Location

Images are pushed to:
```
ghcr.io/<your-username>/ray-baseimage:<version>-<git-hash>
ghcr.io/<your-username>/ray-baseimage:latest
```

### Making the Package Public

By default, GitHub Container Registry packages are private. To make your image public:

1. Go to your GitHub repository
2. Click on "Packages" in the right sidebar
3. Click on the `ray-baseimage` package
4. Click "Package settings"
5. Scroll down to "Danger Zone"
6. Click "Change visibility" and select "Public"

## Usage

### Pull from GitHub Container Registry

```bash
# Pull latest
docker pull ghcr.io/<your-username>/ray-baseimage:latest

# Pull specific version
docker pull ghcr.io/<your-username>/ray-baseimage:2.52.1-gpu-abc1234
```

### Run the container

```bash
docker run -it ghcr.io/<your-username>/ray-baseimage:latest
```

## Customization

You can customize the Docker image by editing the `Dockerfile`. For example:

- Install additional Python packages
- Add custom scripts or configurations
- Set environment variables
- Configure Ray settings

## Available Ray Versions

Check the [Ray Docker Hub](https://hub.docker.com/r/rayproject/ray/tags) for available versions. Common tags include:

- `2.52.1-gpu` - GPU support
- `2.52.1-cpu` - CPU only
- `2.52.1-py310` - Specific Python version
- `nightly-gpu` - Latest nightly build with GPU support

## License

This project configuration is provided as-is. Ray itself is licensed under Apache 2.0.
