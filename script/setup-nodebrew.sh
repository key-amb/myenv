#!/usr/bin/env bash

set -euo pipefail

NODE_VERSION=${NODE_VERSION:-v6.2.1}
NODEBREW_ROOT=$HOME/.nodebrew

if [[ ! -d $NODEBREW_ROOT ]]; then
  curl -L git.io/nodebrew | perl - setup
fi

PATH=$HOME/.nodebrew/current/bin:$PATH

if ! (nodebrew ls | grep $NODE_VERSION >/dev/null 2>&1); then
  nodebrew install-binary $NODE_VERSION
  nodebrew alias default $NODE_VERSION
  nodebrew use $NODE_VERSION
fi

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-nodebrew.sh> - Bootstrap nodebrew

=head1 SYNOPSYS

    setup-nodebrew.sh
    NODE_VERSION=v6.2.1 setup-nodebrew.sh

=head1 DESCRIPTION

blah blah blah.

=head1 SEE ALSO

L<https://github.com/hokaccha/nodebrew>

=head1 AUTHORS

IKEDA Kiyoshi E<lt>progrhyme@gmail.comE<gt>

=cut

__EOF__

