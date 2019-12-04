# Base docker image
FROM ubuntu:18.04

# Install inkscape
RUN set -x && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:inkscape.dev/stable && \
    apt-get update

RUN set -x && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

RUN set -x && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        ttf-mscorefonts-installer \
        inkscape

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

# Autorun inkscape
ENTRYPOINT [ "inkscape" ]

