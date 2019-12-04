# Base docker image
FROM ubuntu:18.04

# Install vlc
RUN set -x && \
    apt-get update && apt-get install -y \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    vlc

# Cleanup apt
RUN set -x && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add app user
RUN set -x && \
    groupadd -g 1000 app && \
    useradd -m -s /bin/bash -u 1000 -g app -G audio,video app

# Create downloads directory
RUN set -x && \
    mkdir -p /home/app/Downloads && \
    chown app:app /home/app/Downloads

# Run vlc as a non-privileged user
USER app

# Change working directory to home directory
WORKDIR /home/app

# Create vlc config dir
RUN set -x && \
    mkdir -p ~/.config/vlc

# Set the default playback speed to 1.65
RUN set -x && \
    echo "rate=1.65" > ~/.config/vlc/vlcrc

# Always show status bar
RUN set -x && \
    echo "[MainWindow]" > ~/.config/vlc/vlc-qt-interface.conf && \
    echo "status-bar-visible=true" >> ~/.config/vlc/vlc-qt-interface.conf

# Autorun vlc
ENTRYPOINT [ "vlc" ]
CMD [ "--no-qt-privacy-ask" ]

