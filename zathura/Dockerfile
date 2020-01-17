# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app app

ENV DEBIAN_FRONTEND=noninteractive

# Install zathura dependencies
RUN set -x && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository ppa:jonathonf/meson && \
    apt-get update && \
    apt-get install -y \
        wget \
        g++ \
        pkg-config \
        meson \
        cmake \
        gettext \
        libgtk-3-0 \
        libmagic1 \
        libglib2.0-0 \
        libglib2.0-dev \
        libgtk-3-0 \
        libgtk-3-dev \
        libsqlite3-dev

# Install mupdf dependencies
RUN set -x && \
    apt-get install -y \
        mesa-common-dev \
        libglu1-mesa-dev \
        libgl1-mesa-dev

# Install zathura-djvu dependencies
RUN set -x && \
    apt-get install -y \
        libdjvulibre-dev

###############
# Build mupdf #
###############

RUN set -x && \
    mkdir /tmp/build-mupdf

WORKDIR /tmp/build-mupdf

RUN set -x && \
    wget https://www.mupdf.com/downloads/archive/mupdf-1.16.1-source.tar.xz && \
    tar -xJf mupdf-1.16.1-source.tar.xz

WORKDIR /tmp/build-mupdf/mupdf-1.16.1-source

RUN set -x && \
    XCFLAGS=-fPIC make prefix=/home/app/installs/mupdf-1.16.1 -j 4 install

################
# Build girara #
################

RUN set -x && \
    mkdir /tmp/build-girara

WORKDIR /tmp/build-girara

RUN set -x && \
    wget https://github.com/pwmt/girara/archive/0.3.4.tar.gz && \
    tar -xzf 0.3.4.tar.gz

WORKDIR /tmp/build-girara/girara-0.3.4

RUN set -x && \
    meson build --prefix=/home/app/installs/girara-v0.3.4

WORKDIR /tmp/build-girara/girara-0.3.4/build

RUN set -x && \
    ninja && ninja install

RUN set -x && \
    cp meson-private/girara-gtk3.pc /usr/share/pkgconfig

RUN bash -c "echo /home/app/installs/girara-v0.3.4/lib/x86_64-linux-gnu >> /etc/ld.so.conf"

RUN set -x && ldconfig

#################
# Build zathura #
#################

RUN set -x && \
    mkdir /tmp/build-zathura

WORKDIR /tmp/build-zathura

RUN set -x && \
    wget https://github.com/pwmt/zathura/archive/0.4.5.tar.gz && \
    tar -xzf 0.4.5.tar.gz

WORKDIR /tmp/build-zathura/zathura-0.4.5

RUN set -x && \
    meson build --prefix=/home/app/installs/zathura-v0.4.5

WORKDIR /tmp/build-zathura/zathura-0.4.5/build

RUN set -x && \
    ninja && ninja install

RUN set -x && \
    cp meson-private/zathura.pc /usr/share/pkgconfig

#######################
# Build zathura-mupdf #
#######################

RUN echo 'x'/tmp/

RUN set -x && \
    mkdir /tmp/build-zathura-mupdf

WORKDIR /tmp/build-zathura-mupdf

RUN set -x && \
    wget https://github.com/pwmt/zathura-pdf-mupdf/archive/0.3.5.tar.gz && \
    tar -xzf 0.3.5.tar.gz

WORKDIR /tmp/build-zathura-mupdf/zathura-pdf-mupdf-0.3.5

RUN set -x && \
    LIBRARY_PATH=/home/app/installs/mupdf-1.16.1/lib meson build --prefix=/home/app/installs/zathura-v0.4.5

WORKDIR /tmp/build-zathura-mupdf/zathura-pdf-mupdf-0.3.5/build

RUN set -x && \
    LIBRARY_PATH=/home/app/installs/mupdf-1.16.1/lib C_INCLUDE_PATH=/home/app/installs/mupdf-1.16.1/include ninja && \
    ninja install

######################
# Build zathura-djvu #
######################

RUN set -x && \
    mkdir /tmp/build-zathura-djvu

WORKDIR /tmp/build-zathura-djvu

RUN set -x && \
    wget https://github.com/pwmt/zathura-djvu/archive/0.2.9.tar.gz && \
    tar -xzf 0.2.9.tar.gz

WORKDIR /tmp/build-zathura-djvu/zathura-djvu-0.2.9

RUN set -x && \
    meson build --prefix=/home/app/installs/zathura-v0.4.5

WORKDIR /tmp/build-zathura-djvu/zathura-djvu-0.2.9/build

RUN set -x && \
    ninja && \
    ninja install

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Cleanup build
RUN set -x && \
    rm -rf /tmp/build-*

# Use correct permissions for the app
RUN set -x && \
    chown -R app:app /home/app/installs

# Run the installed app as a non-privileged app user
USER app

# Set working directory
WORKDIR /home/app/Downloads

# Set application path
ENV PATH="$PATH:/home/app/installs/zathura-v0.4.5/bin"

# # Autorun app
ENTRYPOINT [ "zathura" ]

