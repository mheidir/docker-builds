FROM ubuntu:24.04 AS builder

LABEL version="1.0"
LABEL author="Muhammad Heidir" description="Micetro Controller with BIND on Docker"

ENV DEBIAN_FRONTEND="noninteractive"
ENV LC_ALL="C.UTF-8"

# Build part

RUN apt update && apt -y upgrade && apt -y install python3 bind9
RUN apt clean

# Make sure to download these files:
# https://download.menandmice.com/Linux/25.1.2/micetro-controllers-25.1.2.linux.x64.tgz
# Adding Micetro Controller
ADD micetro-controllers-25.1.2.linux.x64.tgz /tmp
RUN /usr/sbin/named -c /etc/bind/named.conf -u bind && \
    cd /tmp/micetro-controllers-25.1.2.linux.x64 && \
    ./install && \
    rm -rfv /tmp/micetro-controllers-25.1.2.linux.x64

# Runtime part
FROM ubuntu:24.04
ENV LC_ALL="C.UTF-8"

RUN apt update && apt -y upgrade && apt -y install python3 bind9
RUN apt clean

COPY --from=builder /etc/bind /etc/bind
COPY --from=builder /etc/init.d /etc/init.d

RUN mkdir -p /var/mmsuite
COPY --from=builder /var/mmsuite /var/mmsuite

COPY --from=builder /usr/sbin/mmupdaterd /usr/sbin/mmupdaterd
COPY --from=builder /usr/sbin/mmremoted /usr/sbin/mmremoted

COPY --from=builder /var/run/mmupdaterd /var/run/mmupdaterd
COPY --from=builder /var/run/mmremoted /var/run/mmremoted

RUN mkdir -p /var/cache/bind
COPY --from=builder /var/cache/bind /var/cache/bind

COPY --from=builder /etc/default/mmupdater /etc/default/mmupdater
COPY --from=builder /etc/default/mmremote /etc/default/mmremote

COPY startup.sh /
RUN chmod +x /startup.sh

EXPOSE 53/tcp 53/udp 1337/tcp 4603/tcp

CMD /startup.sh
