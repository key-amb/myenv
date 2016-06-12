#!/usr/bin/env bash

set -euo pipefail

PL_VERSION=${PERL_VERSION:-5.24.0}
PLENV_ROOT=$HOME/.plenv

if [[ ! -d $PLENV_ROOT ]]; then
  git clone https://github.com/tokuhirom/plenv.git $PLENV_ROOT
  git clone https://github.com/tokuhirom/Perl-Build.git $PLENV_ROOT/plugins/perl-build/
fi

PATH=$PLENV_ROOT/bin:$PATH
if ! (echo $PATH | grep $HOME/.plenv/shims >/dev/null 2>&1); then
  eval "$(plenv init -)"
fi
PATH=$PLENV_ROOT/shims:$PATH

if ! (plenv versions | grep $PL_VERSION >/dev/null 2>&1); then
  plenv install $PL_VERSION
  plenv global $PL_VERSION
  plenv rehash
  if ! (which cpanm >/dev/null 2>&1); then
    plenv install-cpanm
    plenv rehash
  fi
fi

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-plenv.sh> - Script to bootstrap plenv

=head1 SYNOPSYS

    setup-plenv.sh
    PERL_VERSION=5.24.0 setup-plenv.sh

=head1 DESCRIPTION

blah blah blah.

=head1 SEE ALSO

https://github.com/tokuhirom/plenv

=head1 AUTHORS

YASUTAKE Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__
