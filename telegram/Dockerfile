# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Install telegram dependencies
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        wget \
        xz-utils \
        libxcb1 \
        libx11-6 \
        libx11-xcb1 \
        libglib2.0-0 \
        libdbus-1-3

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch to a non-privileged app user
USER app

# Create telegram installation directory
RUN set -x && mkdir /home/app/installs

# Download telegram
RUN set -x && \
    mkdir /tmp/telegram-download

WORKDIR /tmp/telegram-download

RUN set -x && \
    wget 'https://github.com/telegramdesktop/tdesktop/releases/download/v1.9.9/tsetup.1.9.9.tar.xz'
RUN set -x && \
    tar -xJf tsetup.1.9.9.tar.xz

# Install telegram
RUN set -x && \
    mv Telegram /home/app/installs/telegram-v1.9.9

# Cleanup downloaded files
RUN set -x && \
    rm -rf /tmp/telegram-download

# Set downloads directory as working directory
RUN set -x && \
    mkdir /home/app/Downloads
WORKDIR /home/app/Downloads

# Set telegram path
ENV PATH="$PATH:/home/app/installs/telegram-v1.9.9"

# Autorun telegram
ENTRYPOINT [ "Telegram" ]

