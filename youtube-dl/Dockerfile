# Base docker image
FROM ubuntu:18.04

# Add app user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -G sudo -g app app

# Install pip and ffmpeg
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        python3-pip \
        ffmpeg

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install youtube-dl as a non-privileged user
USER app

# Change working directory to home directory
WORKDIR /home/app

# Install youtube-dl
RUN set -x && \
    pip3 install youtube-dl

# Cleanup pip
RUN set -x && \
    rm -rf ~/.cache/

# Put youtube-dl path in $PATH
ENV PATH=$PATH:/home/app/.local/bin

# Change working directory to downloads directory
WORKDIR /home/app/Downloads

# Run youtube-dl
ENTRYPOINT [ "youtube-dl" ]

