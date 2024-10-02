FROM debian:11.4-slim

ENV DEBIAN_FRONTEND=noninteractive \
    S6_OVERLAY_VERSION=3.1.6.2 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=300000

# updating and installing required components
RUN apt update \
# software-properties-common curl gnupg zip libvips42 git xz-utils sudo htop micro jq
 && apt install --no-install-recommends -y software-properties-common curl xz-utils sudo \
#
 && curl -o /tmp/megacmd.deb https://mega.nz/linux/repo/Debian_11/amd64/megacmd-Debian_11_amd64.deb \
 && apt --no-install-recommends -y  install /tmp/megacmd.deb \
#
# cleaning up
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
#
# installing s6
 && curl -sL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz | tar -C / -Jxpf - \
 && curl -sL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-$([ $(uname -m) = 'aarch64' ] && echo 'aarch64' || echo 'x86_64').tar.xz | tar -C / -Jxpf - \
#
# custom user
 && useradd -u 1000 -ms /bin/bash mega \
 && adduser mega sudo \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER mega
WORKDIR /home/mega/.megaCmd
COPY --chown=mega rootfs /
CMD ["/entrypoint.sh"]

EXPOSE 80
VOLUME /home/mega/.megaCmd
