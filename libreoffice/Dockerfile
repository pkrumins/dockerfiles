# Base docker image
FROM ubuntu:18.04

# Install libreoffice
RUN set -x && \
    apt-get update && \
    apt-get install -y \
        libreoffice

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add app user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Create Downloads directory
RUN set -x && \
    mkdir -p /home/app/Downloads && \
    chown app:app /home/app/Downloads

# Run libreoffice as a non-privileged user
USER app

# Change working directory to docs directory
WORKDIR /home/app/Downloads

# Autorun libreoffice
ENTRYPOINT [ "libreoffice" ]

