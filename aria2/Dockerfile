# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Install dependencies
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        g++ \
        pkg-config \
        make \
        wget

# Build aria2
RUN set -x && \
    mkdir /tmp/build-aria2

WORKDIR /tmp/build-aria2

RUN set -x && \
    wget https://github.com/aria2/aria2/releases/download/release-1.35.0/aria2-1.35.0.tar.xz && \
    tar -xJf aria2-1.35.0.tar.xz

WORKDIR /tmp/build-aria2/aria2-1.35.0

RUN set -x && \
    ./configure \
        --prefix=/home/app/installs/aria2-v1.35.0 && \
    make -j 4 && \
    make install

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cleanup build
RUN set -x && \
    rm -rf /tmp/build-aria2

# Use correct permissions for the app
RUN set -x && \
    chown -R app:app /home/app/installs

# Run the installed app as a non-privileged app user
USER app

# Set working directory
WORKDIR /home/app/Downloads/aria2

# Set application path
ENV PATH="$PATH:/home/app/installs/aria2-v1.35.0/bin"

# Autorun app
ENTRYPOINT [ "aria2c" ]

