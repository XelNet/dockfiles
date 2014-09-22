FROM rbarrois/debpack-base
MAINTAINER Raphaël Barrois <docker@r.xelmail.com>

# Common setup for "debian repository" images

RUN groupadd --gid 2000 debrepo && useradd --uid 2000 --gid 2000 --home-dir /debrepo debrepo
RUN mkdir /debrepo && chown debrepo:debrepo /debrepo
VOLUME /debrepo
