# Base docker image
FROM ubuntu:latest

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Build feedreader
RUN set -x && \
    apt-get update && \
    apt-get install -y \
        wget \
        build-essential \
        meson \
        ninja-build \
        valac \
        libvala-0.40-dev \
        pkg-config \
        libgirepository1.0-dev \
        libgtk-3-dev \
        libgumbo-dev \
        libsoup2.4-dev \
        libjson-glib-dev \
        libwebkit2gtk-4.0-dev \
        libsqlite3-dev \
        libsecret-1-dev \
        libnotify-dev \
        libxml2-dev \
        libunity-dev \
        librest-dev \
        libgee-0.8-dev \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        libgoa-1.0-dev \
        libcurl4 \
        libcurl4-openssl-dev \
        libpeas-dev

RUN set -x && \
    mkdir /tmp/build-feedreader

WORKDIR /tmp/build-feedreader

RUN set -x && \
    wget https://github.com/jangernert/FeedReader/archive/v2.10.0.tar.gz -O feedreader-2.10.0.tar.gz && \
    tar -xzf feedreader-2.10.0.tar.gz

WORKDIR /tmp/build-feedreader/FeedReader-2.10.0

# Remove the call to git as this is not a git repo 
RUN set -x && \
    sed -i -e "s|command : \['git', 'show-ref', '-s', 'refs/heads/master'\],|command : ['echo', 'abcdef'],|" meson.build

RUN set -x && \
    meson builddir --prefix=/home/app/installs/feedreader-v2.10.0 && \
    ninja -C builddir install

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cleanup build
RUN set -x && \
    rm -rf /tmp/build-feedreader

# Run the installed app as a non-privileged app user
USER app

# Set working directory
WORKDIR /home/app

# Set feedreader path
ENV PATH="$PATH:/home/app/installs/feedreader-v2.10.0/bin"

# Autorun feedreader
ENTRYPOINT [ "feedreader" ]

