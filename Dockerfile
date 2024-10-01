FROM debian:11.4-slim

ENV DEBIAN_FRONTEND=noninteractive

# updating and installing required components
RUN apt update \
# software-properties-common curl gnupg zip libvips42 git xz-utils sudo htop micro jq
 && apt install --no-install-recommends -y software-properties-common curl \
#
 && curl -o /tmp/megacmd.deb https://mega.nz/linux/repo/Debian_11/amd64/megacmd-Debian_11_amd64.deb \
 && apt --no-install-recommends -y  install /tmp/megacmd.deb \
#
# cleaning up
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /
CMD ["/entrypoint.sh"]

EXPOSE 80
