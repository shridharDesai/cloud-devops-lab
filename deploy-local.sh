#!/bin/bash

set -e

IMAGE="cloud-devops-lab:local"
CONTAINER="cloud-devops-lab-local"

echo "Building production image..."
docker build --target production -t "$IMAGE" .

echo "Stopping old container if it exists..."
docker rm -f "$CONTAINER" 2>/dev/null || true

echo "Starting new container..."
docker run -d \
  --name "$CONTAINER" \
  -p 5001:5001 \
  "$IMAGE"

echo "Waiting for application..."
sleep 3

echo "Checking health..."
curl --fail http://localhost:5001/health

echo
echo "Deployment successful!"
