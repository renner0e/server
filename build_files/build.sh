#!/bin/bash

set -ouex pipefail

cp -avf "/ctx/system_files"/. /

dnf -y install dnf5-plugins

dnf config-manager setopt keepcache=1

dnf install -y \
  git \
  tmux \
  vim \
  just \
  buildah

systemctl enable podman.socket

dnf config-manager setopt keepcache=0


