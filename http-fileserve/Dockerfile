FROM rbarrois/nginx
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

ADD fileserve /etc/nginx/sites-enabled/

VOLUME ["/data"]

WORKDIR /etc/nginx

EXPOSE 80
CMD ["/usr/sbin/nginx-docker-startup"]
