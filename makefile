# Version variables
MAJOR_VERSION := 0
MINOR_VERSION := 60
PATCH_VERSION := 8-r5
ASPELL_VERSION := $(MAJOR_VERSION).$(MINOR_VERSION).$(PATCH_VERSION)

# Image name
IMAGE_NAME := git.hollandgibson.com/containers/aspell

# Tags
TAG_LATEST := $(IMAGE_NAME):latest
TAG_MAJOR := $(IMAGE_NAME):$(MAJOR_VERSION)
TAG_MINOR := $(IMAGE_NAME):$(MAJOR_VERSION).$(MINOR_VERSION)
TAG_FULL := $(IMAGE_NAME):$(ASPELL_VERSION)

# Platforms
PLATFORMS := linux/amd64,linux/arm64

.PHONY: all build push clean

# Default target
all: build

# Build multi-platform images and load/push
build:
	podman build \
		--build-arg ASPELL_VERSION=$(ASPELL_VERSION) \
		-t $(TAG_LATEST) \
		-t $(TAG_MAJOR) \
		-t $(TAG_MINOR) \
		-t $(TAG_FULL) \
		--platform $(PLATFORMS) \
		-f Dockerfile \
		.

# Build and push to registry
push:
	podman build \
		--build-arg ASPELL_VERSION=$(ASPELL_VERSION) \
		-t $(TAG_LATEST) \
		-t $(TAG_MAJOR) \
		-t $(TAG_MINOR) \
		-t $(TAG_FULL) \
		--platform $(PLATFORMS) \
		-f Dockerfile \
		.
	podman push $(TAG_LATEST)
	podman push $(TAG_MAJOR)
	podman push $(TAG_MINOR)
	podman push $(TAG_FULL)

# Build for single platform (useful for local testing)
build-local:
	podman build \
		--build-arg ASPELL_VERSION=$(ASPELL_VERSION) \
		-t $(TAG_LATEST) \
		-t $(TAG_MAJOR) \
		-t $(TAG_MINOR) \
		-t $(TAG_FULL) \
		-f Dockerfile \
		.

# Show what would be built
info:
	@echo "ASPELL_VERSION: $(ASPELL_VERSION)"
	@echo "Tags:"
	@echo "  - $(TAG_LATEST)"
	@echo "  - $(TAG_MAJOR)"
	@echo "  - $(TAG_MINOR)"
	@echo "  - $(TAG_FULL)"
	@echo "Platforms: $(PLATFORMS)"

# Clean up images
clean:
	-podman rmi $(TAG_LATEST) $(TAG_MAJOR) $(TAG_MINOR) $(TAG_FULL)
