# Base docker image
FROM ubuntu:18.04

# Install utilities
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        software-properties-common \
        gnupg \
        curl \
        wget \
        netcat \
        iputils-ping \
        iptables

# Copy wine apt-key
COPY winehq.key /tmp

# Install winehq.key
RUN set -x && apt-key add /tmp/winehq.key

# Add winehq repository
RUN set -x && \
    apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'

# Enable 32-bit architecture
RUN set -x && dpkg --add-architecture i386

# Install wine
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        winehq-stable

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/winehq.key

# Add app user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Create Downloads directory
RUN set -x && \
    mkdir -p /home/app/Downloads && \
    chown app:app /home/app/Downloads

# Copy winscp into docker
COPY WinSCP-5.15.9-Setup.exe /home/app
RUN set -x && \
    chown app:app /home/app/WinSCP-5.15.9-Setup.exe

# Run wine as a non-privileged user
#USER app

# Change working directory to home directory
#WORKDIR /home/app

# Copy start script into docker
COPY start.sh /home/app

# Autorun bash
ENTRYPOINT [ "/home/app/start.sh" ]

