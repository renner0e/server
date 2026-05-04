FROM quay.io/fedora/fedora:latest AS bootc-builder

RUN --mount=type=cache,dst=/var/cache/libdnf5 <<FETCH_BOOTC
dnf config-manager setopt keepcache=1
dnf -y install git attr
dnf -y builddep bootc
git clone "https://github.com/bootc-dev/bootc.git"
FETCH_BOOTC

WORKDIR bootc
RUN <<EOF
make bin install-all DESTDIR=/output
setfattr -n user.component -v "bootc" /output
EOF

FROM scratch AS ctx
COPY build_files /
COPY --from=bootc-builder /output /system_files
COPY system_files /system_files

FROM quay.io/fedora/fedora-bootc:latest AS raw

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache/libdnf5 \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    /ctx/composefs.sh && \
    /ctx/initramfs.sh

RUN --network=none bootc container lint
