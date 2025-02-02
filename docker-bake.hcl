target "docker-metadata-action" {}

variable "REPO_NAME" {
  default = "ghcr.io/xander-rudolph"
}

variable "SD_IMAGE_NAME" {
  default = "stable-diffusion"
}

variable "SEARXNG_IMAGE_NAME" {
  default = "searxng"
}

group "default" {
  targets = ["multi-tagged","searxng"]
}

target "base" {
  inherits = ["docker-metadata-action"]
  context    = "stable-diffusion"
  tags     = [
    "${REPO_NAME}/${SD_IMAGE_NAME}:latest"
    "${REPO_NAME}/${SD_IMAGE_NAME}:${BUILD_VERSION}"
  ]
  dockerfile = "Dockerfile"
}

target "ext-tagged" {
  inherits = ["base"]
  tags     = ["${REPO_NAME}/${SD_IMAGE_NAME}:ext"]
  args     = {
    addextensions = "true"
  }
}

target "mdl-tagged" {
  inherits = ["base"]
  tags     = ["${REPO_NAME}/${SD_IMAGE_NAME}:mdl"]
  args     = {
    addmodels     = "true"
  }
}

target "multi-tagged" {
  inherits = ["ext-tagged","mdl-tagged"]
  tags     = ["${REPO_NAME}/${SD_IMAGE_NAME}:ext-mdl"]
}

target "searxng" {
  inherits = ["docker-metadata-action"]
  context    = "searxng"
  tags     = ["${REPO_NAME}/${SEARXNG_IMAGE_NAME}:latest"]
  dockerfile = "Dockerfile"
}