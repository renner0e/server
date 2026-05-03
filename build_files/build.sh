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

dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf config-manager setopt tailscale-stable.enabled=0
dnf -y install --enablerepo='tailscale-stable' tailscale

systemctl enable podman.socket
systemctl --global enable podman-auto-update.timer
systemctl enable tailscaled.service

dnf config-manager setopt keepcache=0
