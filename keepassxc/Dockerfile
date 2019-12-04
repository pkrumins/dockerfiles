# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Build keepassxc
RUN set -x && \
    apt-get update && \
    apt-get install -y \
        wget \
        build-essential \
        cmake \
        g++ \
        qtbase5-dev \
        qttools5-dev \
        qttools5-dev-tools libqt5svg5-dev \
        libgcrypt20-dev \
        libargon2-0-dev \
        libqrencode-dev \
        libsodium-dev \
        zlib1g-dev

RUN set -x && \
    mkdir /tmp/build-keepassxc

WORKDIR /tmp/build-keepassxc

RUN set -x && \
    wget 'https://github.com/keepassxreboot/keepassxc/releases/download/2.5.1/keepassxc-2.5.1-src.tar.xz'

RUN echo "ef33258b859a7b996af007113613b0f6210f2341e8f5fb3a005564262c2caf30 keepassxc-2.5.1-src.tar.xz" | sha256sum -c

RUN set -x && \
    tar -xJf keepassxc-2.5.1-src.tar.xz

WORKDIR /tmp/build-keepassxc/keepassxc-2.5.1

RUN set -x && \
    cmake \
        -DCMAKE_INSTALL_PREFIX=/home/app/installs/keepassxc-v2.5.1 \
        -DWITH_XC_UPDATECHECK=OFF \
        -DWITH_TESTS=OFF \
        -DWITH_APP_BUNDLE=OFF \
        -DKEEPASSXC_BUILD_TYPE=release && \
    make -j 4 && \
    make install

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
  
# Cleanup build
RUN set -x && \
    rm -rf /tmp/build-keepassxc

# Create database directory
RUN set -x && \
    mkdir -p /home/app/keepassxc && \
    chown app:app /home/app/keepassxc

# Run the installed app as a non-privileged app user
USER app

# Set working directory
WORKDIR /home/app/keepassxc

# Set keepassxc path
ENV PATH="$PATH:/home/app/installs/keepassxc-v2.5.1/bin"

# Autorun keepassxc
ENTRYPOINT [ "keepassxc" ]

