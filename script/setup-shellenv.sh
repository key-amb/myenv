#!/usr/bin/env bash

set -euo pipefail

base_dir="$(cd $(dirname $0)/..; pwd)"
. $base_dir/lib/setup.bashrc

echo "[START] setup $MYENV"

init_shell

# symlink common/*
mkdir -p $HOME/.config/git
$LINKER $BASE_DIR/common/.config/git/ignore $HOME/.config/git/ignore
$LINKER $PROJ_DIR/common/.gemrc $HOME/.gemrc

env_setup_script="$THE_ENV_DIR/script/setup-shell.shrc"

if [[ -r $env_setup_script ]]; then
  . $env_setup_script
else
  echo "No setup script for env: $MYENV"
fi

echo "[END] setup $MYENV"

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-shellenv.sh> - Script to set up a shell environment

=head1 SYNOPSYS

    MYENV=<target env> script/setup-shellenv.sh

=head1 DESCRIPTION

This script set up a shell environment for current user.

=head1 SEE ALSO

L<script/setup-env.sh>

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__

