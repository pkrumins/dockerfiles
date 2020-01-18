# Base docker image
FROM ubuntu:18.04

# Add app user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Install pip
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        python3-pip

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install mycli as a non-privileged user
USER app

# Change working directory to home directory
WORKDIR /home/app

# Install mycli
RUN set -x && \
    pip3 install mycli

# Cleanup pip
RUN set -x && \
    rm -rf ~/.cache/

# Put mycli path in $PATH
ENV PATH=$PATH:/home/app/.local/bin

# Change working directory to downloads directory
WORKDIR /home/app/Downloads

# Use UTF8 for things
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Run mycli
ENTRYPOINT [ "mycli" ]

