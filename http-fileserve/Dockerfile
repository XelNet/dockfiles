FROM xelnor/nginx
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

ADD fileserve /etc/nginx/sites-enabled/

VOLUME ["/data"]

WORKDIR /etc/nginx
CMD ["nginx"]

EXPOSE 80
#ENTRYPOINT ["/usr/bin/nginx"]
