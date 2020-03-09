# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

ENV DEBIAN_FRONTEND=noninteractive

# Install sxiv dependencies
RUN set -x && \
    apt-get update && \
    apt-get install -y \
        wget \
        libimlib2-dev \
        libxft-dev \
        libexif-dev \
        libgif-dev

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Drop privileges
USER app

# Build sxiv
RUN set -x && \
    mkdir /tmp/build-sxiv

WORKDIR /tmp/build-sxiv

RUN set -x && \
    wget https://github.com/muennich/sxiv/archive/v26.tar.gz && \
    tar -xzf v26.tar.gz

WORKDIR /tmp/build-sxiv/sxiv-26

RUN set -x && \
    make && \
    make PREFIX="/home/app/installs/sxiv-v26" install

# Cleanup build
RUN set -x && \
    rm -rf /tmp/build-sxiv

# Set working directory
WORKDIR /home/app/Downloads

# Set application path
ENV PATH="$PATH:/home/app/installs/sxiv-v26/bin"

# Autorun app
ENTRYPOINT [ "sxiv" ]

