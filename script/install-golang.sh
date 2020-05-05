#!/usr/bin/env bash

set -euo pipefail

GO_VERSION=1.11
OS=${OS:-linux}
ARCH=${ARCH:-amd64}
GOROOT=${GOROOT:-"/usr/local/go"} # last dir must be "go"

if [[ -x $GOROOT/bin/go ]]; then
  echo "[INFO] go is already installed at ${GOROOT}."
  exit 0
fi

package="go${GO_VERSION}.${OS}-${ARCH}"

cd tmp
wget "https://storage.googleapis.com/golang/${package}.tar.gz"
sudo tar -C ${GOROOT%/*} -xvzf $package.tar.gz

rm -rf ./$package.tar.gz

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<install-golang.sh> - summary

=head1 SYNOPSYS

    install-golang.sh

=head1 DESCRIPTION

blah blah blah.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>progrhyme@gmail.comE<gt>

=head1 LICENSE

The MIT License (MIT)

Copyright (c) 2016 IKEDA Kiyoshi

=cut

__EOF__

