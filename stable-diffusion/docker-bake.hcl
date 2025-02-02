target "docker-metadata-action" {}

group "default" {
  targets = ["base", "ext", "mdl", "ext-mdl"]
}

target "base" {
  inherits = ["docker-metadata-action"]
  context    = "."
  dockerfile = "Dockerfile"
  tags       = ["latest"]
}

target "ext" {
  inherits = ["base"]
  tags     = ["ext"]
  args     = {
    addextensions = "true"
  }
}

target "mdl" {
  inherits = ["base"]
  tags     = ["mdl"]
  args     = {
    addmodels = "true"
  }
}

target "ext-mdl" {
  inherits = ["base"]
  tags     = ["ext-mdl"]
  args     = {
    addextensions = "true"
    addmodels     = "true"
  }
}
