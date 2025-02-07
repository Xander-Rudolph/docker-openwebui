#!/bin/bash

if [ "$1" = "true" ]; then
    if [ -z "$HF_TOKEN" ]; then
        echo "HF_TOKEN environment variable is not set. Skipping model downloads."
    else
        echo "Downloading models..."

        base_url="https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main"
        dest_dir="/data/models/Stable-diffusion" # Checkpoints directory

        declare -A files=(
            ["flux1-dev.safetensors"]="$base_url/flux1-dev.safetensors"
        )

        for file in "${!files[@]}"; do
            full_path="$dest_dir/$file"
            mkdir -p "$(dirname "$full_path")"
            echo "Downloading ${files[$file]} to $full_path"
            curl -L --progress-bar -H "Authorization: Bearer $HF_TOKEN" -o "$full_path" "${files[$file]}"
        done

        echo "Model downloads complete."
    fi
else
    echo "Skipping model downloads."
fi
