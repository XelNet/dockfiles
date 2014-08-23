FROM xelnor/xelbuntu
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>
RUN apt-get -qq update
RUN apt-get install -qqy nginx
RUN \
        echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
        chown -R www-data:www-data /var/lib/nginx && \
        rm /etc/nginx/sites-enabled/default
