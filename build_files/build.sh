#!/bin/bash

set -ouex pipefail

cp -avf "/ctx/system_files"/. /

sed -i "s/enabled=1/enabled=0/" /etc/yum.repos.d/fedora-cisco-openh264.repo

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
