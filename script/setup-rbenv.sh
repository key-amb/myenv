#!/usr/bin/env bash

set -euo pipefail

base_dir="$(cd $(dirname $0)/..; pwd)"
. $base_dir/lib/setup.bashrc

pre_exec_script

RB_VERSION=${RUBY_VERSION:-2.3.3}
RBENV_ROOT=$HOME/.rbenv

if [[ ! -d $RBENV_ROOT ]]; then
  git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT
  git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build/
fi

PATH=$RBENV_ROOT/bin:$PATH
if ! (echo $PATH | grep $HOME/.rbenv/shims >/dev/null 2>&1); then
  eval "$(rbenv init -)"
fi
PATH=$RBENV_ROOT/shims:$PATH

if ! (rbenv versions | grep $RB_VERSION >/dev/null 2>&1); then
  rbenv install $RB_VERSION -v
  rbenv global $RB_VERSION
  rbenv rehash
fi

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-rbenv.sh> - Script to bootstrap rbenv

=head1 SYNOPSYS

    setup-rbenv.sh
    RUBY_VERSION=2.3.1 setup-rbenv.sh
    MYENV=ubuntu-desktop setup-rbenv.sh # Exec pre-hook

=head1 DESCRIPTION

blah blah blah.

=head1 SEE ALSO

https://github.com/rbenv/rbenv

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__
