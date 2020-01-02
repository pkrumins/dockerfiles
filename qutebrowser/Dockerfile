# Base docker image
FROM ubuntu:18.04

# Add app group and user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app -G audio,video app

# Install qutebrowser dependencies
RUN set -x && \
    apt-get update && \
    apt-get install -y \
        gpg \
        wget \
        python3 \
        python3-pyqt5 \
        python3-pyqt5.qtquick \
        python3-pyqt5.qtwebengine \
        python3-pyqt5.qtopengl \
        python3-pyqt5.qtsql \
        python3-pyqt5.qtquick \
        python3-pip \
        libpulse0

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Run the installed app as a non-privileged app user
USER app

# Download qutebrowser
RUN set -x && \
    mkdir /home/app/installs

WORKDIR /home/app/installs

RUN set -x && \
    wget https://github.com/qutebrowser/qutebrowser/releases/download/v1.8.3/qutebrowser-1.8.3.tar.gz

# Check qutebrowser signature
COPY florian-bruhin.pub /home/app/installs
COPY qutebrowser-1.8.3.tar.gz.asc /home/app/installs
RUN gpg -q --import florian-bruhin.pub
RUN gpg -q --verify qutebrowser-1.8.3.tar.gz.asc

# Setup qtbrowser
RUN set -x && \
    tar -xzf qutebrowser-1.8.3.tar.gz

WORKDIR /home/app/installs/qutebrowser-1.8.3

RUN pip3 install -r requirements.txt

# Cleanup build
RUN set -x && \
    rm -rf /home/app/installs/qutebrowser-1.8.3.tar.gz* /home/app/installs/florian-bruhin.pub

# Set working directory
WORKDIR /home/app/Downloads

# Set qutebrowser path
ENV PATH="$PATH:/home/app/installs/qutebrowser-1.8.3"

# Autorun quotebrowser
ENTRYPOINT [ "qutebrowser.py" ]

