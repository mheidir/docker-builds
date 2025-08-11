#!/bin/bash
echo "[INFO] Building docker container image: dmicetro"
docker build -t dmicetro:25.1.2 .

echo "[INFO] Starting container: dmicetro"
docker run -d --name dmicetro -p 8001:80 dmicetro:25.1.2

docker logs dmicetro

docker ps -a

exit 0
