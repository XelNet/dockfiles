XelNet dockfiles
================

This repositories holds a set of Dockerfile for XelNet services.


Design
------

All images are based on ``debian:jessie``.
They manage a service, or part of it.

An image will contain "all required bits" to get the service running, including syslog and nginx.
But some parts can be disabled.

Please refer to the README in each folder for expectations of each image.



