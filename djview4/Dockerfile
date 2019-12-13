# Base docker image
FROM ubuntu:18.04

# Install djview4
RUN set -x && \
    apt-get update && apt-get install -y \
    djview4

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add app user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Create downloads directory
RUN set -x && \
    mkdir -p /home/app/Downloads && \
    chown app:app /home/app/Downloads

# Run djview4 as a non-privileged user
USER app

# Change working directory to home directory
WORKDIR /home/app/Downloads

# Autorun djview4
ENTRYPOINT [ "djview4" ]

