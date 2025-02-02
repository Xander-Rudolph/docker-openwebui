#!/bin/bash
if [ "$1" = "true" ]; then
    echo "Downloading models..."

    base_url="https://huggingface.co/ckpt/ControlNet/resolve/main"
    dest_dir="extensions/sd-webui-controlnet"

    declare -A files=(
        ["models/control_canny-fp16.safetensors"]="$base_url/control_canny-fp16.safetensors"
        ["models/control_depth-fp16.safetensors"]="$base_url/control_depth-fp16.safetensors"
        ["models/control_hed-fp16.safetensors"]="$base_url/control_hed-fp16.safetensors"
        ["models/control_mlsd-fp16.safetensors"]="$base_url/control_mlsd-fp16.safetensors"
        ["models/control_normal-fp16.safetensors"]="$base_url/control_normal-fp16.safetensors"
        ["models/control_openpose-fp16.safetensors"]="$base_url/control_openpose-fp16.safetensors"
        ["models/control_scribble-fp16.safetensors"]="$base_url/control_scribble-fp16.safetensors"
        ["models/control_seg-fp16.safetensors"]="$base_url/control_seg-fp16.safetensors"
        ["annotator/openpose/hand_pose_model.pth"]="$base_url/hand_pose_model.pth"
        ["annotator/openpose/body_pose_model.pth"]="$base_url/body_pose_model.pth"
        ["annotator/midas/dpt_hybrid-midas-501f0c75.pt"]="$base_url/dpt_hybrid-midas-501f0c75.pt"
        ["annotator/mlsd/mlsd_large_512_fp32.pth"]="$base_url/mlsd_large_512_fp32.pth"
        ["annotator/mlsd/mlsd_tiny_512_fp32.pth"]="$base_url/mlsd_tiny_512_fp32.pth"
        ["annotator/hed/network-bsds500.pth"]="$base_url/network-bsds500.pth"
        ["annotator/uniformer/upernet_global_small.pth"]="$base_url/upernet_global_small.pth"
        ["models/t2iadapter_style_sd14v1.pth"]="$base_url/t2iadapter_style_sd14v1.pth"
        ["models/t2iadapter_sketch_sd14v1.pth"]="$base_url/t2iadapter_sketch_sd14v1.pth"
        ["models/t2iadapter_seg_sd14v1.pth"]="$base_url/t2iadapter_seg_sd14v1.pth"
        ["models/t2iadapter_openpose_sd14v1.pth"]="$base_url/t2iadapter_openpose_sd14v1.pth"
        ["models/t2iadapter_keypose_sd14v1.pth"]="$base_url/t2iadapter_keypose_sd14v1.pth"
        ["models/t2iadapter_depth_sd14v1.pth"]="$base_url/t2iadapter_depth_sd14v1.pth"
        ["models/t2iadapter_color_sd14v1.pth"]="$base_url/t2iadapter_color_sd14v1.pth"
        ["models/t2iadapter_canny_sd14v1.pth"]="$base_url/t2iadapter_canny_sd14v1.pth"
    )

    for file in "${!files[@]}"; do
        full_path="$dest_dir/$file"
        mkdir -p "$(dirname "$full_path")"
        echo "Downloading ${files[$file]} to $full_path"
        curl -L --progress-bar -o "$full_path" "${files[$file]}"
    done

else
    echo "Skipping model downloads."
fi
