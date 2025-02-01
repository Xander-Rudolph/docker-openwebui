# Stable Diffusion AI Model Deployment with Docker

This repository provides a Docker setup for deploying the Stable Diffusion AI model. The Docker image uses the official NVIDIA PyTorch container as a base and includes all necessary dependencies for running the Stable Diffusion WebUI and model. This repository provides a quick and easy way to set up [Open WebUI](https://github.com/open-webui/open-webui) with all the additional features.

## Requirements

- Docker installed on your system
- NVIDIA GPU with CUDA support (GPU is optional if you want to use CPU mode)

Currently, this setup is optimized for NVIDIA hardware, but I plan to add AMD configurations as well. For instructions on setting up the NVIDIA SDK, refer to [this tutorial](https://www.containerssimplified.com/container/running-ollama-on-your-local-machine-with-nvidia-gpus/).

## Details

The Dockerfile used in this repository sets up an environment with Python 3.10, necessary dependencies, PyTorch with CUDA support, and clones the required repositories (Stable Diffusion WebUI and Stable Diffusion). The working directory is set to `/usr/src`, and the command to start the WebUI with NVIDIA GPU acceleration and skip torch CUDA test is specified in the ENTRYPOINT.

The docker-compose file allows for easy management of multiple services, including the Stable Diffusion WebUI, model service, and necessary volumes for storing data.

## Switching profiles

The docker compose file is set to handle 3 profiles:
- default (no gpu pods)
- NVIDIA
- AMD

Specify the --profile to ensure the appropriate pods start:
```
docker compose --profile default up -d
```

to spool down
```
docker compose --profile default down
```

## Updating the Repository

If updates to the repositories are made, you can rebuild the Docker image by running:
```
docker build -t stable-diffusion .
```

### About the Dockerfile
The `stable-diffusion/AUTOMATIC1111` is quite large, and I suspect the limitations around image size are why I can't find any of the old docker images I use to use. To address this issue, I have created a Docker image based on a recent CUDA base image. Building this image may take several minutes (5+ minutes).

### Only stable-diffusion

1. Build the Docker image by running the following command in a terminal:
   ```
   docker build -t stable-diffusion .
   ```

2. Run the container with the following command:
   ```
   docker run --gpus all -p 7860:7860 -d stable-diffusion
   ```
   If you don't have a GPU, use the following command instead:
   ```
   docker run -p 7860:7860 -d stable-diffusion
   ```

3. Open your web browser and visit `http://localhost:7860` to access the Stable Diffusion WebUI.

## Example usage
1. Create a file named `.env` next to the `docker-compose` file and add the following content:

```markdown
# Any variables that are commented out are defaulted and do not need to be defined
# -------------
# Ports stuff
# -------------
OPEN_WEBUI_PORT=8081
SEARXNG_PORT=8080
SD_WEBUI_PORT=7860
OLLAMA_PORT=11434
PIPER_PORT=59125
FASTERWHISPER_PORT=5001
# if you are using ollama in the cluster, ensure you use the --profile arg in your docker compose to use NVIDIA or AMD
# OLLAMA_HOST=localhost

# -------------
# Data storage
# -------------
BASE_DIR=${USERPROFILE}/openweb-complete
SD_DATA_DIR=${BASE_DIR}/stablediffusion/data
SD_MODELS_DIR=${BASE_DIR}/stablediffusion/models
SD_CONFIG_DIR=${BASE_DIR}/stablediffusion/config
SD_OUTPUTS_DIR=${BASE_DIR}/stablediffusion/outputs
LAMA_DATA_DIR=${BASE_DIR}/ollama-data
OWUI_DATA_DIR=${BASE_DIR}/openwebui-data
TTS_MODELS=${BASE_DIR}/tts/models
STT_MODELS=${BASE_DIR}/stt/models
SEARCH_DIR=${BASE_DIR}/searxng

# -------------
# GPU stuff
# -------------
# NVIDIA_VISIBLE_DEVICES=all
# NVIDIA_DRIVER_CAPABILITIES=compute,utility
# OLLAMA_IMAGE=ollama/ollama #nvidia

# -------------
# Search stuff
# -------------
# ENABLE_RAG_WEB_SEARCH= True
# RAG_WEB_SEARCH_ENGINE= searxng
# RAG_WEB_SEARCH_RESULT_COUNT= 3
# RAG_WEB_SEARCH_CONCURRENT_REQUESTS= 10
# SEARXNG_HOSTNAME=localhost 
# UWSGI_WORKERS= 4
# UWSGI_THREADS= 4
```

2. Run the following command
```bash
docker-compose up -d
```

This will create a folder called `openweb-complete` in your user directory and the required subfolders for each application. Feel free to customize this setup according to your preferences. The `docker-compose` file contains the hardcoded port numbers that the Docker images use, allowing you to map them as needed locally. Run:

**Note:** If you just restarted ollama, it may take some time for the first model load before it starts responding. The first message always takes a while.

## Troubleshooting

- If you encounter any issues with the Docker setup, please make sure that you have installed Docker correctly and have the necessary GPU support (if using a GPU). You may also want to check the [Docker documentation](https://docs.docker.com/engine/install/) for help troubleshooting Docker-related problems.

## Image sizes
The images used in this setup are large, so keep that in mind:
- ollama: 4.91GB
- open-webui: 5.91GB
- stable-diffusion: 13.29GB

Be prepared for your system to require a significant amount of free disk space and for your video card to experience strain during operation.

## Flow
```mermaid
sequenceDiagram
    participant User as User
    participant DockerContainer as Docker Container

    User->>DockerContainer: Run docker build
    DockerContainer->>BaseImage: Download Base Image
    DockerContainer-->>User: Build complete
    DockerContainer->>Dependencies: Install Dependencies
    Dependencies->>Python3: Add Python 3.10
    Python3->>Default Python3: Set Default Python 3.10
    Default Python3->>PyTorch: Install PyTorch with CUDA support
    PyTorch->>SDWebUI: Clone Stable Diffusion WebUI repository
    SDWebUI->>Working Directory: Set Working Directory
    Working Directory->>stable-diffusion: Clone stable-diffusion repository
    stable-diffusion->>Port Exposure: Expose Default Port for the WebUI
    Port Exposure->>Command: Command to Start WebUI with NVIDIA GPU Acceleration
    User->>DockerContainer: Run docker run
    DockerContainer->>Command: Execute command within container
```

## Contributing

Contributions are always welcome! If you would like to contribute, please fork this repository, make your changes, and submit a pull request.

## What still needs to be done:
[ ] Test - search
[ ] Update openweb for search params
[ ] Test - TTS
[ ] Update openweb for TTS
[ ] Test - STT
[ ] Update openweb for STT (right now its usuing built in whisper)
[ ] Update openweb for image generation
[ ] Research Video models
