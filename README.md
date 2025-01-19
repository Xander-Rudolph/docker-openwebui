# docker-openwebui

This repo is to tie together a quick and easy way to spool up [open-webui](https://github.com/open-webui/open-webui) with all the bells and whistles. 

## Prep your environment
This all depends on nvidia stuff right now, however I plan to add AMD configs as well. 

[This tutorial is a pretty good breakdown of how to get nvidia sdk working](https://www.containerssimplified.com/container/running-ollama-on-your-local-machine-with-nvidia-gpus/).

## Whats with the dockerfile?
stable-diffusion/AUTOMATIC1111 is pretty huge and I suspect the limitations around image size are why I can't find any of the old docker images I use to use. For that reason, I put together one that is off a recent cuda base image. This image build does take some time to build (5+ minutes at least), so be patient.

## Example usage
Create a file called .env next to where the docker-compose file is and put the following content:
```
# Ports
SD_WEBUI_PORT=7860
OPEN_WEBUI_PORT=8080
OLLAMA_PORT=11434

# GPU Configuration
NVIDIA_VISIBLE_DEVICES=all
NVIDIA_DRIVER_CAPABILITIES=compute,utility

# Volume Directories (adjust paths to your system)
BASE_DIR=${USERPROFILE}/openweb-complete
SD_DATA_DIR=${BASE_DIR}/stablediffusion/data
SD_MODELS_DIR=${BASE_DIR}/stablediffusion/models
SD_CONFIG_DIR=${BASE_DIR}/stablediffusion/config
SD_OUTPUTS_DIR=${BASE_DIR}/stablediffusion/outputs
LAMA_DATA_DIR=${BASE_DIR}/ollama-data
OWUI_DATA_DIR=${BASE_DIR}/openwebui-data
```

This will create a folder called openweb-complete in your user directory and the child folders that the apps need to run. Feel free to reconfigure this any way you like. The docker-compose contains the hard coded port numbers that the docker iamges use so you can map them where ever you need locally. Then, simply run:

```
docker-compose up -d
```
NOTE: if you just restarted ollama, the first time it loads a model it will take time before it starts to respond. The first message always takes some time.

## image sizes

These images are big so keep that in mind:
ollama            4.91GB
open-webui        5.91GB
stable-diffusion 13.29GB

Models are also very big so prepare to have a large amount of free disk space and for your video care to scream in pain.