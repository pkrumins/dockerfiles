# Base docker image
FROM ubuntu:18.04

# Update package list
RUN set -x && \
    apt-get update

# Install utilities
RUN set -x && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo \
        curl \
        wget \
        netcat \
        whois \
        gcc \
        g++ \
        make \
        vim \
        less \
        sqlite3

# Install nginx, php
RUN set -x && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        nginx \
        php-fpm \
        php-mbstring \
        php-curl \
        php-sqlite3 \
        php-mysql

# Install mariadb
RUN set -x && \
    apt-get install -y \
        mariadb-server

# Set timezone
RUN set -x && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Make mysql listen on all ips
RUN set -x && \
    sed -i '/^bind-address/s/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Allow root to access mysql from anywhere
RUN set -x && echo 1 && \
    service mysql start && \
    mysql -u root -D mysql -e "UPDATE user SET Host='%', plugin='mysql_native_password' WHERE User='root'" && \
    mysql -u root -e "FLUSH PRIVILEGES" && \
    mysqladmin -u root -h 127.0.0.1 shutdown

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

# Copy service startup script
COPY start.sh /start.sh

# Make start.sh runnable
RUN set -x && chmod +x /start.sh

# Run test container as a non-privileged user
USER app

# Change working directory to home directory
WORKDIR /home/app

# Start services
ENTRYPOINT [ "/start.sh" ]

