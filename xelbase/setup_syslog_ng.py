#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import os
import re
import sys

SYSLOG_CONFIG_PATH = '/etc/syslog-ng/destination.conf'
SYSLOG_ENV_VAR = 'SYSLOG_TARGET'
SYSLOG_DEFAULT_SETUP = 'file:/var/log/messages'


class InvalidSyntax(Exception):
    pass


class SetupGenerator(object):
    def _validate_filename(self, path):
        if path.endswith('/') or not path.startswith('/'):
            raise InvalidSyntax("Invalid filename %r" % path)

    host_port_re = re.compile(r'([a-z0-9.-]+|\[[0-9a-f:]+\]):(\d+)')

    def _extract_hostport(self, target):
        match = self.host_port_re.match(target)
        if not match:
            raise InvalidSyntax("Invalid host:port %r" % target)

        return match.groups()

    def gen_file_destination(self, syslog_target):
        self._validate_filename(syslog_target)

        return """file("%(path)s");""" % dict(path=syslog_target)

    def gen_socket_destination(self, syslog_target):
        self._validate_filename(syslog_target)

        return """unix-stream("%(sock)s");""" % dict(sock=syslog_target)

    def gen_tcp_destination(self, syslog_target):
        host, port = self._extract_hostport(syslog_target)

        return """syslog("%(host)s" transport("tcp") port("%(port)s"));""" % dict(
            host=host,
            port=port,
        )

    def gen_udp_destination(self, syslog_target):
        host, port = self._extract_hostport(syslog_target)

        return """syslog("%(host)s" transport("udp") port("%(port)s"));""" % dict(
            host=host,
            port=port,
        )
       
    def gen_setup(self, syslog_target):
        generators = {
            'file': self.gen_file_destination,
            'socket': self.gen_socket_destination,
            'tcp': self.gen_tcp_destination,
            'udp': self.gen_udp_destination,
        }

        if ':' not in syslog_target:
            raise InvalidSyntax("Invalid target %r: missing protocol." % syslog_target)
        proto, target = syslog_target.split(':', 1)
        if proto not in generators:
            raise InvalidSyntax("Invalid proto %r in %r." % (proto, syslog_target))

        dest = generators[proto](target)

        return "destination d_output { %s };\n" % dest


def main(argv):
    parser = argparse.ArgumentParser("Generate the syslog-ng configuration.")
    parser.add_argument('-n', '--dry-run', action='store_true', help="Print the file on stdout instead of writing it.")
    parser.add_argument('-o', '--output', default=SYSLOG_CONFIG_PATH, metavar='OUTPUT',
        help="Write configuration to OUTPUT")
    parser.add_argument('-e', '--envvar', default=SYSLOG_ENV_VAR, help="Read setup from the ENVVAR variable.")
    parser.add_argument('-d', '--default', default=SYSLOG_DEFAULT_SETUP, help="Default value when ENVVAR is unset.")

    args = parser.parse_args(argv)
    target = os.environ.get(args.envvar, args.default)
    try:
        setup = SetupGenerator().gen_setup(target)
    except InvalidSyntax as e:
        sys.stderr.write("Invalid syntax: %s\n" % e)
        sys.exit(1)

    if args.dry_run:
        sys.stdout.write(setup)

    else:
        with open(args.output, 'w') as f:
            f.write(setup)


if __name__ == '__main__':
    main(sys.argv[1:])


