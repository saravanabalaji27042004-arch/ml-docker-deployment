#!/bin/bash
set -e

APP_DIR="/opt/ml-docker-deployment"
IMAGE_NAME="iris-ml-api"
CONTAINER_NAME="iris-ml-container"

cd "$APP_DIR"

docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

docker build -t "$IMAGE_NAME" .

docker run -d \
  --name "$CONTAINER_NAME" \
  --restart unless-stopped \
  -p 8000:8000 \
  "$IMAGE_NAME"

docker ps --filter "name=$CONTAINER_NAME"

echo "ML API deployment completed!"
