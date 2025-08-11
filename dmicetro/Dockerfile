FROM ubuntu:24.04 AS builder

LABEL version="1.0"
LABEL author="Muhammad Heidir" description="Micetro Web and Central on Docker"

ENV DEBIAN_FRONTEND="noninteractive"
ENV LC_ALL="C.UTF-8"

# Build part

RUN apt update && apt -y upgrade && apt -y install python3 apache2 apache2-utils
RUN apt clean

# Make sure to download these files:
# https://download.menandmice.com/Linux/25.1.2/micetro-web-application-25.1.2.linux.x64.tgz
# https://download.menandmice.com/Linux/25.1.2/micetro-central-25.1.2.linux.x64.tgz
# Adding Micetro Web Application
ADD micetro-web-application-25.1.2.linux.x64.tgz /tmp
RUN /etc/init.d/apache2 start && cd /tmp/micetro-web-application-25.1.2.linux.x64 && \
    ./install --web-virtual-host-domain mm.systemx.sg && \
    rm -rfv /tmp/micetro-web-application-25.1.2.linux.x64

# Adding Micetro Central
ADD micetro-central-25.1.2.linux.x64.tgz /tmp
RUN cd /tmp/micetro-central-25.1.2.linux.x64 && ./install


# Runtime part
FROM ubuntu:24.04
ENV LC_ALL="C.UTF-8"

RUN apt update && apt -y upgrade && apt -y install python3 apache2 apache2-utils
RUN apt clean
RUN a2enmod proxy_http

RUN rm /etc/apache2/sites-enabled/000-default.conf

RUN mkdir -p /var/mmsuite
COPY --from=builder /var/mmsuite /var/mmsuite
COPY --from=builder /usr/sbin/mmwsd /usr/sbin/mmwsd
COPY --from=builder /usr/sbin/mmupdaterd /usr/sbin/mmupdaterd
COPY --from=builder /usr/sbin/mmcentrald /usr/sbin/mmcentrald

RUN mkdir -p /etc/apache2/conf
COPY --from=builder /etc/apache2/conf /etc/apache2/sites-enabled

COPY --from=builder /var/run/mmwsd /var/run/mmwsd
COPY --from=builder /var/run/mmupdaterd /var/run/mmupdaterd
COPY --from=builder /var/run/mmcentrald /var/run/mmcentrald

RUN mkdir -p /var/www/mm.systemx.sg
COPY --from=builder /var/www/mm.systemx.sg /var/www/mm.systemx.sg
COPY --from=builder /etc/init.d/mmws /etc/init.d/mmws
COPY --from=builder /etc/init.d/mmupdater /etc/init.d/mmupdater
COPY --from=builder /etc/init.d/mmcentral /etc/init.d/mmcentral

COPY --from=builder /etc/default/mmws /etc/default/mmws
COPY --from=builder /etc/default/mmupdater /etc/default/mmupdater
COPY --from=builder /etc/default/mmcentral /etc/defaultmmcentral

RUN rm /var/mmsuite/mmcentral/mmsuite.db

COPY startup.sh /
RUN chmod +x /startup.sh

EXPOSE 80/tcp 4603/tcp

#ENTRYPOINT ["/etc/init.d/apache2", "start"]
CMD /startup.sh
