target "docker-metadata-action" {}

variable "IMAGE_NAME" {
  default = "ghcr.io/xander-rudolph/stable-diffusion"
}

group "default" {
  targets = ["multi-tagged"]
}

target "base" {
  inherits = ["docker-metadata-action"]
  context    = "stable-diffusion"
  tags     = ["${IMAGE_NAME}:latest"]
  dockerfile = "Dockerfile"
}

target "ext-tagged" {
  inherits = ["base"]
  tags     = ["${IMAGE_NAME}:ext"]
  args     = {
    addextensions = "true"
  }
}

target "mdl-tagged" {
  inherits = ["base"]
  tags     = ["${IMAGE_NAME}:mdl"]
  args     = {
    addmodels     = "true"
  }
}

target "multi-tagged" {
  inherits = ["ext-tagged","mdl-tagged"]
  tags     = ["${IMAGE_NAME}:ext-mdl"]
}
