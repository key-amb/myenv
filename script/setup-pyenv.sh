#!/usr/bin/env bash

set -euo pipefail

base_dir="$(cd $(dirname $0)/..; pwd)"
. $base_dir/lib/setup.bashrc

pre_exec_script

PYTHON_VERSION=${PYTHON_VERSION:-2.7.12}
PYENV_ROOT=$HOME/.pyenv

if [[ ! -d $PYENV_ROOT ]]; then
  git clone https://github.com/yyuu/pyenv.git $PYENV_ROOT
fi

PATH=$PYENV_ROOT/bin:$PATH
if ! (echo $PATH | grep $HOME/.pyenv/shims >/dev/null 2>&1); then
  eval "$(pyenv init -)"
fi
PATH=$PYENV_ROOT/shims:$PATH

if ! (pyenv versions | grep $PYTHON_VERSION >/dev/null 2>&1); then
  pyenv install $PYTHON_VERSION -v
  pyenv global $PYTHON_VERSION
  pyenv rehash
fi

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-pyenv.sh> - Script to bootstrap pyenv

=head1 SYNOPSYS

    setup-pyenv.sh
    PYTHON_VERSION=3.5.2 setup-pyenv.sh
    MYENV=ubuntu-desktop setup-pyenv.sh # Exec pre-hook

=head1 DESCRIPTION

blah blah blah.

=head1 SEE ALSO

https://github.com/yyuu/pyenv

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__
