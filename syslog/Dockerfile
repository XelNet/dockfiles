FROM xelnet/xelbase
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

# Extra packages
RUN \
        apt-get update -qq && \
        apt-get install -qqy syslog-ng && \
        apt-get clean

RUN useradd --system --home-dir /logs --user-group log

# Configuration
ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf


# Data
VOLUME ["/devext", "/config", "/logs"]

# Run
CMD ["/usr/sbin/syslog-ng", "--no-caps", "--foreground"]

EXPOSE 514/udp 514/tcp
