#!/bin/bash
echo "[INFO] Building docker container image: micedns"
docker build -t micedns:25.1.2 .

echo "[INFO] Starting container: micedns"
docker run -d --name micedns -p 192.168.5.43:53:53/tcp -p 192.168.5.43:53:53/udp micedns:25.1.2

docker logs micedns

docker ps -a

exit 0
