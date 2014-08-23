FROM xelnor/nginx
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

# Extra packages
RUN apt-get install -qqy supervisor fcgiwrap git

# Binaries
RUN mkdir /gitweb
RUN ln -s /usr/share/gitweb/index.cgi /gitweb/gitweb.cgi

# Configuration
ADD gitserve.nginx /etc/nginx/sites-enabled/
ADD gitweb.conf /etc/gitweb.conf
COPY theme /gitweb/theme

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Data
VOLUME ["/git"]

# Run
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

EXPOSE 80
