FROM debian:jessie
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

# Base image for 'serving' jobs.

RUN \
        echo "APT::Install-Recommends \"false\";\nAPT::Install-Suggests \"false\";\nAPT::Cache-Limit 22582912;" >> /etc/apt/apt.conf

RUN apt-get update -qqy && \
        apt-get install -qqy python-pip runit syslog-ng && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install bicti

ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
ADD setup_syslog_ng.py /etc/startup/setup_syslog_ng
