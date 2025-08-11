#!/bin/bash
echo "[INFO] Stopping container: micedns"
docker stop micedns

echo "[INFO] Removing container: micedns"
docker rm micedns

exit 0
