rbarrois/debuild
================

A simple image for building Debian packages.

This is basically your usual chroot, but dockerized :)


Contents
--------

- All basic Debian building tools


Volumes
-------

This image expects two volumes:

.. data:: /tarballs

    A place where upstream tarballs are available

.. data:: /src

    Mount the folder containing the 'debian/' folder here

Those volumes will be assembled into::

    /pkg (from /tarballs)
    └── src (from /src)
        └── debian

