#!/bin/sh

if [ "$1" = "true" ]; then
    # This appears to load modules but not sure if I need it yet... See https://github.com/camenduru/stable-diffusion-webui-docker/blob/2a51924c744dc7a5e452b3996f9c40ab20a3683c/Dockerfile.Stable#L23C1-L23C167"
    curl -L -o scripts/run_n_times.py https://raw.githubusercontent.com/camenduru/stable-diffusion-webui-scripts/main/run_n_times.py

    echo "Cloning WebUI extensions..."
    git clone https://github.com/deforum-art/deforum-for-automatic1111-webui extensions/deforum-for-automatic1111-webui
    git clone https://github.com/AlUlkesh/stable-diffusion-webui-images-browser extensions/stable-diffusion-webui-images-browser
    git clone https://github.com/camenduru/stable-diffusion-webui-huggingface extensions/stable-diffusion-webui-huggingface
    git clone https://github.com/Vetchems/sd-civitai-browser extensions/sd-civitai-browser
    git clone https://github.com/kohya-ss/sd-webui-additional-networks extensions/sd-webui-additional-networks
    git clone https://github.com/Mikubill/sd-webui-controlnet extensions/sd-webui-controlnet
    # Added to resolve ControlNet init warning
    pip install --no-cache-dir insightface
    git clone https://github.com/camenduru/openpose-editor extensions/openpose-editor
    # Resolve dependency on extensions/openpose-editor/scripts/main.py
    pip install --no-cache-dir basicsr
    git clone https://github.com/jexom/sd-webui-depth-lib extensions/sd-webui-depth-lib
    git clone https://github.com/hnmr293/posex extensions/posex
    git clone https://github.com/camenduru/sd-webui-tunnels extensions/sd-webui-tunnels
    git clone https://github.com/etherealxx/batchlinks-webui extensions/batchlinks-webui
    echo "Extensions cloned successfully."
else
    echo "Skipping extension cloning."
fi
