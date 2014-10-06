FROM xelnet/xelbase
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

# Setup ppa (until nginx 1.7 is available in jessie)
RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" > /etc/apt/sources.list.d/nginx-mainline-wheezy.list
ADD nginx_signing.key /tmp/nginx_signing.key
RUN apt-key add /tmp/nginx_signing.key

RUN apt-get -qq update
RUN apt-get install -qqy nginx

# For standard Debian package
#RUN \
#        echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
#        chown -R www-data:www-data /var/lib/nginx && \
#        rm /etc/nginx/sites-enabled/default
ADD nginx-docker-startup /usr/sbin/
ADD nginx-docker-setup /usr/sbin/
ADD nginx.conf /etc/nginx/nginx.conf.in

# Provide a default, valid nginx.conf
RUN nginx-docker-setup
