FROM ubuntu:14.04
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>
RUN apt-get -qq update
RUN apt-get install -qqy nginx
RUN \
        echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
        chown -R www-data:www-data /var/lib/nginx && \
        rm /etc/nginx/sites-enabled/default

ADD fileserve /etc/nginx/sites-enabled/

VOLUME ["/data"]

WORKDIR /etc/nginx
CMD ["nginx"]

EXPOSE 80
#ENTRYPOINT ["/usr/bin/nginx"]
