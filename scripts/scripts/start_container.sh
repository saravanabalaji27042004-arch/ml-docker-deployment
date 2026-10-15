#!/bin/bash
set -e

APP_DIR="/opt/ml-docker-deployment"
IMAGE_NAME="iris-ml-api"
CONTAINER_NAME="iris-ml-container"

cd "$APP_DIR"

echo "Stopping existing container if running..."
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "Building Docker image..."
docker build -t "$IMAGE_NAME" .

echo "Starting ML prediction API..."
docker run -d \
  --name "$CONTAINER_NAME" \
  --restart unless-stopped \
  -p 8000:8000 \
  "$IMAGE_NAME"

echo "Checking container status..."
docker ps --filter "name=$CONTAINER_NAME"

echo "ML API deployment completed!"
