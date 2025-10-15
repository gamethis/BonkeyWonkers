#!/bin/bash
# Pull commonly used Docker images for exercises
# Run this script in background or when needed

echo "Pulling Docker images for exercises"
echo "=============================================="

echo "Pulling test container..."
docker pull dahicks/sample:latest &
PID1=$!

echo "Pulling stress test container..."
docker pull j0hnewhitley/docker-stress:v0.0.1 &
PID2=$!

echo "Waiting for downloads to complete..."
wait $PID1
echo "✓ dahicks/sample:latest"

wait $PID2
echo "✓ j0hnewhitley/docker-stress:v0.0.1"

echo ""
echo "All Docker images pulled successfully!"