# Image template but made for local automatic builds!

Heavily Inspired by:
- https://universal-blue.discourse.group/t/locally-built-automatically-updating-custom-bootc-image/11706/9 
- https://github.com/akdev1l/zerolayer

Docs: https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html

I am using this for my server which just runs a bunch of containers and I got tired of debian flakiness.

How to build and update locally?

`sudo systemctl start --verbose bootc-image-factory-build.service`

`sudo systemctl enable bootc-image-factory-build.timer`
