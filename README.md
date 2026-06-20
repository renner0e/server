# Image template but made for local automatic builds!

Heavily Inspired by:
- https://universal-blue.discourse.group/t/locally-built-automatically-updating-custom-bootc-image/11706/9 
- https://github.com/akdev1l/zerolayer

# Usual image-template stuff

Do the usual boilerplate stuff for the image-template:
- edit `image-template.env`, or leave it stock, doesn't really matter
- Make your changes to `Containerfile` and `build.sh` and so on

# Do this once

Copy the `system_files` folder from here into your copy of the template

Generally briefly touched on over [here](https://github.com/ublue-os/image-template#switching-to-the-locally-built-image-for-testing).

## Build and rebase

```
sudo just build
```

If you left it stock, this is the image tag you want, otherwise whatever you set in `image-template.env`

```
sudo bootc switch --transport containers-storage localhost/image-template:latest
```

reboot

You are now on the local image, now you are responsible for building your own images for getting updates! This part previously was done in github by the Universal Blue Team/whoever

git runs as root in the systemd service but the repo is owned by your user (you likely want to keep your changes in git and push it to a remote like github)

```
sudo git config --system --add safe.directory /directory/of/image-template
```

Change the paths to point to your actual directory

```
sudo systemctl edit bootc-image-template.service
```

```ini
[Service]
WorkingDirectory=-/var/home/alice/Projects/myimage
```

# How to build and update locally?

See build and rebase section for the manual way but instead of `bootc switch` you do `sudo bootc upgrade`

There is a systemd service that does this for you

```
sudo systemctl start --verbose image-template-local-build.service
```

Opt-in for automatic updates to run this on a schedule

```
sudo systemctl enable image-template-local-build.timer
```

# Go back to your original upstream image

```
sudo bootc switch --enforce-container-sigpolicy ghcr.io/ublue-os/bazzite:stable
```

and so on
