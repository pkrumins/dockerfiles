# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Install dependencies
RUN set -x && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        gcc \
        g++ \
        make \
        wget \
        curl \
        intltool \
        pkg-config \
        libglib2.0-dev \
        libxml2-dev \
        libgtk-3-dev \
        libgdk-pixbuf2.0-dev \
        libmpfr-dev \
        libcurl4-openssl-dev

######################
# Build libqalculate #
######################
RUN set -x && \
    mkdir /tmp/build-libqalculate

WORKDIR /tmp/build-libqalculate

RUN set -x && \
    wget https://github.com/Qalculate/libqalculate/releases/download/v3.6.0/libqalculate-3.6.0.tar.gz && \
    tar -xzf libqalculate-3.6.0.tar.gz

WORKDIR /tmp/build-libqalculate/libqalculate-3.6.0

RUN set -x && \
    ./configure \
        --prefix=/home/app/installs/libqalculate-v3.6.0 && \
    make -j 4 && \
    make install

RUN set -x && \
    cp /home/app/installs/libqalculate-v3.6.0/lib/pkgconfig/libqalculate.pc /usr/lib/pkgconfig

#######################
# Build qalculate-gtk #
#######################
RUN set -x && \
    mkdir /tmp/build-qalculate-gtk

WORKDIR /tmp/build-qalculate-gtk

RUN set -x && \
    wget https://github.com/Qalculate/qalculate-gtk/releases/download/v3.6.0/qalculate-gtk-3.6.0.tar.gz && \
    tar -xzf qalculate-gtk-3.6.0.tar.gz

WORKDIR /tmp/build-qalculate-gtk/qalculate-gtk-3.6.0

RUN set -x && \
    ./configure \
        --prefix=/home/app/installs/qalculate-gtk-v3.6.0 && \
    make -j 4 && \
    make install

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cleanup build
RUN set -x && \
    rm -rf /tmp/build-libqalculate && \
    rm -rf /tmp/build-qalculate-gtk

# Use correct permissions for the app
RUN set -x && \
    chown -R app:app /home/app/installs

# Run the installed app as a non-privileged app user
USER app

# Set working directory
WORKDIR /home/app

# Set application path
ENV PATH="$PATH:/home/app/installs/libqalculate-v3.6.0/bin"
ENV PATH="$PATH:/home/app/installs/qalculate-gtk-v3.6.0/bin"

# Create config dir as qalculate errors without it
RUN set -x && \
    mkdir -p /home/app/.config/qalculate

# Autorun app
ENTRYPOINT [ "qalculate-gtk" ]

