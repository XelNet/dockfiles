FROM rbarrois/debpack-repobase
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

# Common setup for "debian repository" images

RUN apt-get update -qqy && \
        apt-get install -qqy ssh && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /sshd-keys
EXPOSE 22

ADD sshd_config /etc/ssh/sshd_config
ADD run-sshd /usr/local/bin/

CMD ["/usr/local/bin/run-sshd"]
