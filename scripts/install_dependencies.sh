#!/bin/bash
set -e

echo "Checking Docker installation..."

if ! command -v docker >/dev/null 2>&1; then
    if command -v dnf >/dev/null 2>&1; then
        dnf install -y docker
    elif command -v yum >/dev/null 2>&1; then
        yum install -y docker
    elif command -v apt-get >/dev/null 2>&1; then
        apt-get update
        apt-get install -y docker.io
    else
        echo "Unsupported Linux package manager"
        exit 1
    fi
fi

systemctl enable docker
systemctl start docker

echo "Docker is ready!"
