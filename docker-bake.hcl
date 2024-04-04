variable "major_version" {
  default = "0"
}

variable "minor_version" {
  default = "60"
}

variable "patch_version" {
  default = "8-r5"
}

group "default" {
  targets = ["main"]
}

target "main" {
  args = {
    ASPELL_VERSION = "${major_version}.${minor_version}.${patch_version}"
  }
  dockerfile = "Dockerfile"
  tags = [
    "docker.io/hgibs/aspell:latest",
    "docker.io/hgibs/aspell:${major_version}",
    "docker.io/hgibs/aspell:${major_version}.${minor_version}",
    "docker.io/hgibs/aspell:${major_version}.${minor_version}.${patch_version}",
  ]
  platforms = ["linux/amd64", "linux/arm64"]
}
