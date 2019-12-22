#!/bin/bash
#

set -ueo pipefail

# Start nginx
#
sudo service nginx start || {
    echo "Error: Nginx failed to start, error code: $?."
    exit 1
}

# Start php
#
sudo service php7.2-fpm start || {
    echo "Error: Php failed to start, error code: $?."
    exit 1
}

# Start mysql
#
sudo service mysql start || {
    echo "Error: Mysql failed to start, error code: $?."
    exit 1
}

# Prevent docker from exiting
#
while :; do
    sleep 3600
done

