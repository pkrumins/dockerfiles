# Base docker image
FROM ubuntu:18.04

# Install krita
RUN set -x && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository ppa:kritalime/ppa && \
    apt-get update && \
    apt-get install -y krita

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Create downloads directory
RUN set -x && \
    mkdir -p /home/app/Downloads && \
    chown app:app /home/app/Downloads

# Run the installed app as a non-privileged app user
USER app

# Set working directory
WORKDIR /home/app/Downloads

# Autorun krita
ENTRYPOINT [ "krita" ]

