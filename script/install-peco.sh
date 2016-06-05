#!/usr/bin/env bash

set -euo pipefail

PECO_VERSION=0.3.6
OS=${OS:-linux}
ARCH=${ARCH:-amd64}

if which peco >/dev/null 2>&1; then
  if peco --version 2>&1 | grep $PECO_VERSION >/dev/null 2>&1; then
    echo "[OK] peco v${PECO_VERSION} already installed."
    exit 0
  fi
fi

package="peco_${OS}_${ARCH}"

cd tmp
wget "https://github.com/peco/peco/releases/download/v${PECO_VERSION}/${package}.tar.gz"
tar xvzf $package.tar.gz
sudo cp $package/peco /usr/local/bin/peco

rm -rf ./peco_*

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<install-peco.sh> - 

=head1 SYNOPSYS

    install-peco.sh
    env OS=linux ARCH=amd64 install-peco.sh

=head1 DESCRIPTION

blah blah blah.

=head1 AUTHORS

YASUTAKE Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__
