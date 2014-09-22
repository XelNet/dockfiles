FROM rbarrois/debpack-base
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

# Base image for debian builds.

VOLUME /pkg/incoming
VOLUME /pkg/output

ADD build.sh /pkg/build.sh

CMD ["/pkg/build.sh"]
