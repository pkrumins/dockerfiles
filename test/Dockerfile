# Base docker image
FROM ubuntu:latest

# Install useful utilities
RUN set -x && \
    apt-get update && \
    apt-get install -y \
    sudo \
    curl \
    wget \
    netcat \
    whois
 
# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add app user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -G sudo -g app app

# Add app user to sudoers file
RUN set -x && \
    echo "app ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Run test container as a non-privileged user
USER app

# Change working directory to home directory
WORKDIR /home/app

# Autorun bash
ENTRYPOINT [ "/bin/bash" ]

