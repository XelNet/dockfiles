FROM debian:jessie
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

# Base image for build jobs.

RUN \
        echo "APT::Install-Recommends \"false\";\nAPT::Install-Suggests \"false\";\nAPT::Cache-Limit 22582912;" >> /etc/apt/apt.conf
