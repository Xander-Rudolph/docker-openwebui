# Use the official NVIDIA PyTorch container as a base image
FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    TORCH_CUDA_ARCH_LIST="7.5 8.0 8.6" \
    FORCE_CUDA="1"

# Install Python 3.10 and other dependencies
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

# Set Python 3.10 as the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Install PyTorch with CUDA support before cloning repositories
RUN pip3 install --no-cache-dir torch==2.1.2 torchvision==0.16.2 --extra-index-url https://download.pytorch.org/whl/cu121

# Clone the Stable Diffusion WebUI repository
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /usr/src

# Set working directory
WORKDIR /usr/src/

# Clone the stable-diffusion repository
RUN git clone https://github.com/Stability-AI/stablediffusion.git ./repositories/stable-diffusion-stability-ai

# Expose the default port for the WebUI
EXPOSE 7860

# Command to start the WebUI with NVIDIA GPU acceleration and skip torch CUDA test
ENTRYPOINT ["python3", "launch.py", "--listen", "--port", "7860", "--skip-torch-cuda-test"]