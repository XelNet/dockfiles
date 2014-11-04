FROM xelnet/gentoo-base
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

VOLUME /etc/portage
VOLUME /usr/portage
VOLUME /var/portage
VOLUME /var/binpkg
VOLUME /var/lib/layman

ADD build_portage.sh /usr/local/sbin/

CMD ["/usr/local/sbin/build_portage.sh"]
