#!/usr/bin/env bash

set -euo pipefail

base_dir="$(cd $(dirname $0)/..; pwd)"
. $base_dir/lib/setup.bashrc

GO_PACKAGES=(
  "peco:0.4.2"
  "hub:2.2.8"
)

cd $BASE_DIR/submodule/install-github-go-binary
for gopkg in ${GO_PACKAGES[@]}; do
  _ifs=$IFS
  IFS=:
  set -- $gopkg
  sudo bin/install-github-go-binary $1 $2
  IFS=$_ifs
done

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<install-go-binaries.sh> - 

=head1 SYNOPSYS

    install-go-binaries.sh

=head1 DESCRIPTION

blah blah blah.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>progrhyme@gmail.comE<gt>

=cut

__EOF__

