#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$HOME/.myenv
. $BASE_DIR/lib/package/dpkg.bashrc

install_pkg libssl-dev libreadline-dev zlib1g-dev

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<pre-install-setup-rbenv.sh> - 

=head1 SYNOPSYS

    pre-install-setup-rbenv.sh

=head1 DESCRIPTION

blah blah blah.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__

