#!/bin/bash
echo "[INFO] Stopping container: dmicetro"
docker stop dmicetro

echo "[INFO] Removing container: dmicetro"
docker rm dmicetro

exit 0
