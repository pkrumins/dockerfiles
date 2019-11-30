# Base docker image
FROM ubuntu:latest

# Install r
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    r-base

# Set timezone
RUN set -x && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

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
WORKDIR /home/app

# Autorun r
ENTRYPOINT [ "R" ]

