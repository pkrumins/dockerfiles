# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

ENV DEBIAN_FRONTEND=noninteractive

# Install meld
RUN set -x && \
    apt-get update && \
    apt-get install -y \
        meld

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Run the installed app as a non-privileged app user
USER app

# Set working directory
WORKDIR /home/app/Downloads

# Autorun app
ENTRYPOINT [ "meld" ]

