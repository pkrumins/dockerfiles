# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Build rdesktop
RUN set -x && \
    apt-get update && \
    apt-get install -y \
        gcc \
        make \
        wget \
        libx11-dev \
        libkrb5-dev \
        libgss-dev \
        libxcursor-dev

RUN set -x && \
    mkdir /tmp/build-rdesktop

WORKDIR /tmp/build-rdesktop

RUN set -x && \
    wget https://github.com/rdesktop/rdesktop/releases/download/v1.9.0/rdesktop-1.9.0.tar.gz && \
    tar -xzf rdesktop-1.9.0.tar.gz

WORKDIR /tmp/build-rdesktop/rdesktop-1.9.0

RUN set -x && \
    ./configure \
        --prefix=/home/app/installs/rdesktop-v1.9.0 \
        --disable-smartcard && \
    make -j 4 && \
    make install

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cleanup build
RUN set -x && \
    rm -rf /tmp/build-rdesktop

# Run the installed app as a non-privileged app user
USER app

# Set working directory
WORKDIR /home/app

# Set rdesktop path
ENV PATH="$PATH:/home/app/installs/rdesktop-v1.9.0/bin"

# Autorun rdesktop
ENTRYPOINT [ "rdesktop" ]

