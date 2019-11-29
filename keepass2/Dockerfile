# Base docker image
FROM ubuntu:latest

# Install keepass2
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    keepass2

# Set timezone 
RUN set -x && \
    ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Cleanup apt
RUN set -x && \
    apt-get purge --auto-remove -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add app user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Create keepass2 directory
RUN set -x && \
    mkdir -p /home/app/keepass2 && \
    chown -R app:app /home/app/keepass2

# Run keepass2 as a non-privileged user
USER app

# Change working directory to home directory
WORKDIR /home/app

# Autorun VLC
ENTRYPOINT [ "keepass2" ]

