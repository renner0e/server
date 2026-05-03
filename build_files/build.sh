#!/bin/bash

set -ouex pipefail
dnf config-manager setopt keepcache=1

dnf install -y \
  git \
  tmux \
  vim \
  just

systemctl enable podman.socket

dnf config-manager setopt keepcache=0

