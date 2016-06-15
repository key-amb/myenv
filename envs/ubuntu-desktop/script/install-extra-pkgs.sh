#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$HOME/.myenv
. $BASE_DIR/lib/package/dpkg.bashrc

install_pkg \
  slack-desktop \
  silversearcher-ag

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<install-extra-pkgs> - 

=head1 SYNOPSYS

    install-extra-pkgs

=head1 DESCRIPTION

blah blah blah.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__
