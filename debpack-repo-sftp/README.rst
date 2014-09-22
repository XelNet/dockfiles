rbarrois/debpack-repo-sftp
==========================

SFTP incoming server for the debpack-repo family.

This image accepts SFTP connections for the debrepo user so that new packages can be uploaded.

Contents
--------

A restrictive sshd configuration, that will only accept public key authentication for the ``debrepo`` user within the ``sftp`` subsystem.

On startup, the image will:

- Generate SSHD host keys if needed (their public fingerprints will be sent to stdout)
- Write down the authorized keys provided in :envvar:`SSH_PUBKEYS`
- Execute ``sshd`` and redirect its logs to stderr.


Volumes
-------

- ``/debrepo`` should be mounted to the same docker volume used by debpack-repobuild and debpack-repo-httpserve
- ``/sshd-keys`` can be used to persist SSHD host keys


Environment
-----------

.. envvar:: SSH_PUBKEYS

    Contents of the authorized_keys for incoming connections.


Ports
-----

This image listens on TCP port 22.

