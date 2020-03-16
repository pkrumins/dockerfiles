# Base docker image
FROM ubuntu:19.10

# Install gnupg
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        software-properties-common \
        gnupg

# Copy wine apt-key
COPY winehq.key /tmp

# Install winehq.key
RUN set -x && apt-key add /tmp/winehq.key

# Add winehq repository
RUN set -x && \
    apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ eoan main'

# Enable 32-bit architecture
RUN set -x && dpkg --add-architecture i386

# Install wine and winetricks
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        winehq-stable \
        winetricks

# Install windows utilities
RUN set -x && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        p7zip-full \
        winbind

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

# Run wine as a non-privileged user
USER app

# Change working directory to Downloads
WORKDIR /home/app/Downloads

# Autorun app
ENTRYPOINT [ "wine", "c:/program files/adobe/adobe photoshop cc 2015 (32 bit)/photoshop.exe" ]

