FROM rbarrois/debpack-repobase
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

# Image for building/updating a Debian repository
# Watches for incoming packages in /debrepo/incoming.

RUN apt-get update -qqy && \
        apt-get install -qqy mini-dinstall daemontools && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD run-mini-dinstall /usr/local/bin/
ADD mini-dinstall.conf /etc/mini-dinstall.conf

USER debrepo
CMD ["/usr/local/bin/run-mini-dinstall"]
