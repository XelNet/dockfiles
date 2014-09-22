FROM rbarrois/xelbuild
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

# Base image for debian builds.

RUN apt-get update -qqy && \
        apt-get install -qqy build-essential devscripts equivs && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

