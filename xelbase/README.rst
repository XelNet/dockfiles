xelnet/xelbase
==============

This image is the core on top of which each other image is built.


Contents
--------

- A default ``apt.conf`` configuration (don't install recommends)
- ``runit`` and ``bicti`` for job management
- A default ``syslog`` setup for proper log collection


Volumes
-------

This image doesn't require specific volumes.

A volume could be mounted for use when :envvar:`SYSLOG_TARGET` is set to a ``file:`` scheme.


Environment
-----------

.. envvar:: SYSLOG_TARGET

    Defines where to send logs.

    Options are:

    * ``file:/var/log``: Send to the following folder
    * ``tcp:host:port``: Send to the given host/port through TCP (all fields mandatory)
    * ``udp:host:port``: Send to the given host/port through UDP (all fields mandatory)
    * ``sock:/run/log/syslog.sock``: Stream to the given UNIX socket


Ports
-----

No listening service.
