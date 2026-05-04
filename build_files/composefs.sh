#!/usr/bin/env bash
set -xeuo pipefail

rm -rf /etc/dnf/protected.d/grub*
dnf -y do --action=install systemd-boot-unsigned --action=remove bootupd grub2-pc

