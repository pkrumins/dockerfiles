# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

# Install mypaint and libmypaint dependencies
RUN set -x && \
    apt-get update

RUN set -x && \
    apt-get install -y \
        git \
        swig \
        gettext \
        g++ \
        gir1.2-gtk-3.0 \
        libgtk-3-dev \
        libpng-dev \
        liblcms2-dev \
        libjson-c-dev \
        python-gi-dev \
        python3-setuptools \
        python3-dev \
        python3-numpy \
        python3-gi-cairo \
        libgirepository1.0-dev \
        intltool \
        gettext \
        libtool

# Download mypaint, libmypaint, mypaint-brushes
RUN set -x && \
    mkdir /tmp/build-mypaint

WORKDIR /tmp/build-mypaint

RUN set -x && \
    git clone https://github.com/mypaint/mypaint-brushes.git && \
    git clone https://github.com/mypaint/libmypaint.git && \
    git clone https://github.com/mypaint/mypaint.git

# Build mypaint brushes
WORKDIR /tmp/build-mypaint/mypaint-brushes

# Run autogen.sh twice because it fails the first time
RUN set -x && \
    bash autogen.sh; true
RUN set -x && \
    bash autogen.sh

RUN set -x && \
    bash configure --prefix=/home/app/installs/mypaint-brushes && \
    make && \
    make install
    
# Build libmypaint
WORKDIR /tmp/build-mypaint/libmypaint

ENV CFLAGS "-Ofast -ftree-vectorize -fopt-info-vec-optimized -march=native -mtune=native -funsafe-math-optimizations -funsafe-loop-optimizations"

RUN set -x && \
    bash autogen.sh

RUN set -x && \
    bash configure --prefix=/home/app/installs/libmypaint && \
    make -j 4 && \
    make install

# Update ldconfig path
RUN set -x && \
    echo "/home/app/installs/libmypaint/lib" > /etc/ld.so.conf.d/libmypaint.conf && \
    ldconfig

# Build mypaint
WORKDIR /tmp/build-mypaint/mypaint

ENV PKG_CONFIG_PATH "/home/app/installs/libmypaint/lib/pkgconfig:/home/app/installs/mypaint-brushes/share/pkgconfig"

RUN set -x && \
    python3 setup.py build -j 4 && \
    python3 setup.py managed_install --prefix=/home/app/installs/mypaint

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cleanup build
RUN set -x && \
    rm -rf /tmp/build-mypaint

# Create downloads directory
RUN set -x && \
    mkdir -p /home/app/Downloads && \
    chown app:app /home/app/Downloads

# Run the installed app as a non-privileged app user
USER app

# Set working directory
WORKDIR /home/app/Downloads

# Set mypaint path
ENV PATH="$PATH:/home/app/installs/mypaint/bin"

# Autorun mypaint
ENTRYPOINT [ "mypaint" ]

