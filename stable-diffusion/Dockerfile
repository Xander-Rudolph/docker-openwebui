FROM nvidia/cuda:12.6.3-cudnn-runtime-ubuntu20.04

# Maintainer Information
LABEL org.opencontainers.image.authors="Xander-Rudolph"
LABEL org.opencontainers.image.contact="https://github.com/Xander-Rudolph"
LABEL org.opencontainers.image.source="https://github.com/xander-rudolph/docker-openwebui"
LABEL org.opencontainers.image.vendor="stable-diffusion"
LABEL org.opencontainers.image.title="CUDA-enabled stable diffusion"
LABEL org.opencontainers.image.description="Image for running stable diffusion with GPU support"
LABEL org.opencontainers.image.usage="This image is intended for using and enabling stable diffusion inside of open-webui."
LABEL org.opencontainers.image.created="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
LABEL org.opencontainers.image.base="nvidia/cuda:12.6.3-cudnn-runtime-ubuntu20.04"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    TORCH_CUDA_ARCH_LIST="7.5 8.0 8.6" \
    FORCE_CUDA="1" \
    COMMANDLINE_ARGS='--medvram --xformers --enable-insecure-extension-access'

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    python3.10 \
    python3.10-distutils \
    python3.10-dev \
    git \
    build-essential \
    curl \
    libgl1 \
    && curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Get the source
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /data

# Set Python 3.10 as the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Install PyTorch with CUDA support
RUN pip3 install --no-cache-dir torch==2.1.2 torchvision==0.16.2 --extra-index-url https://download.pytorch.org/whl/cu121

# Added to resolve ControlNet init warning
RUN pip3 install --no-cache-dir insightface

# Resolve dependency on extensions/openpose-editor/scripts/main.py
RUN pip3 install --no-cache-dir basicsr

WORKDIR /data

# create the sub paths
RUN mkdir -p \
    models \ 
    outputs \
    outputs/extras-images \
    outputs/img2img-grids \
    outputs/img2img-images \
    outputs/txt2img-grids \
    outputs/txt2img-images \
    logs \
    repositories \ 
    extensions \
    && chmod -R 777 /data

# Add minimum reqiuirements to make it work
RUN git clone https://github.com/Stability-AI/stablediffusion.git repositories/stable-diffusion-stability-ai

# Define build-time arguments
ARG addextensions=false
ARG addmodels=false

# Make them available as environment variables
ENV ADD_EXTENSIONS=${addextensions}
ENV ADD_MODELS=${addmodels}

# Copy scripts for conditional execution
ADD --chmod=755 ./clone_extensions.sh ./clone_extensions.sh
ADD --chmod=755 ./download_models.sh ./download_models.sh

# Run conditional scripts
RUN ./clone_extensions.sh $ADD_EXTENSIONS && \
    ./download_models.sh $ADD_MODELS 

# Expose the default port for the WebUI
EXPOSE 7860

# Command to start the WebUI with NVIDIA GPU acceleration, and skip torch CUDA test, as well as enables API calls for open-webui
ENTRYPOINT ["python3", "launch.py", "--listen", "--port", "7860", "--skip-torch-cuda-test", "--xformers", "--cors-allow-origins=*", "--api"]
