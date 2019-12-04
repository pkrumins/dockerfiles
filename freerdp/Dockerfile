# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Build freerdp
RUN set -x && \
    apt-get update && \
    apt-get install -y \
        wget \
        ninja-build \
        build-essential \
        debhelper \
        cdbs \
        dpkg-dev \
        autotools-dev \
        cmake \
        pkg-config \
        libssl-dev \
        libxkbfile-dev \
        libx11-dev \
        libwayland-dev \
        libxrandr-dev \
        libxi-dev \
        libxrender-dev \
        libxext-dev \
        libxinerama-dev \
        libxfixes-dev \
        libxcursor-dev \
        libxv-dev \
        libxdamage-dev \
        libxtst-dev \
        libcups2-dev \
        libpcsclite-dev \
        libasound2-dev \
        libpulse-dev \
        libjpeg-dev \
        libgsm1-dev \
        libusb-1.0-0-dev \
        libudev-dev \
        libdbus-glib-1-dev \
        uuid-dev \
        libgss-dev \
        libgss3 \
        libkrb5-dev \
        libkrb5-3

RUN set -x && \
    mkdir /tmp/build-freerdp

WORKDIR /tmp/build-freerdp

RUN set -x && \
    wget https://github.com/FreeRDP/FreeRDP/archive/2.0.0-rc4.tar.gz -O freerdp-2.0.0-rc4.tar.gz && \
    tar -xzf freerdp-2.0.0-rc4.tar.gz

WORKDIR /tmp/build-freerdp/FreeRDP-2.0.0-rc4

RUN set -x && \
    cmake -GNinja \
        -DCMAKE_INSTALL_PREFIX=/home/app/installs/freerdp-v2.0.0-rc4 \
        -DCHANNEL_URBDRC=ON \
        -DWITH_MANPAGES=OFF \
        -DWITH_WAYLAND=OFF \
        -DWITH_X264=OFF \
        -DWITH_CUPS=OFF \
        -DWITH_FFMPEG=OFF \
        -DWITH_DSP_FFMPEG=OFF \
        -DWITH_FAAC=OFF \
        -DWITH_FAAD2=OFF \
        -DWITH_JPEG=ON \
        -DWITH_ALSA=ON \
        -DWITH_PULSE=ON \
        -DWITH_GSM=ON \
        -DWITH_GSSAPI=ON \
        . && \
    cmake --build . --target install

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cleanup build
RUN set -x && \
    rm -rf /tmp/build-freerdp

# Run the installed app as a non-privileged app user
USER app

# Set working directory
WORKDIR /home/app

# Set freerdp path
ENV PATH="$PATH:/home/app/installs/freerdp-v2.0.0-rc4/bin"

# Autorun freerdp
ENTRYPOINT [ "xfreerdp" ]

