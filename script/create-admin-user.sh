#!/usr/bin/env bash

set -euo pipefail

help() {
  local err=${1:-"ERROR!"}
  echo -e "$err\n" >&2
  pod2text $0
  exit 1
}

[[ ${1:-} ]] || help "Please specify username to create!"
ADMIN=$1
shell=${ADMIN_SHELL:-/bin/bash}

sudo useradd -m -s $shell $ADMIN

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<create-admin-user.sh> - Create administrative user

=head1 SYNOPSYS

    create-admin-user.sh <USER>
    ADMIN_SHELL=/bin/dash create-admin-user.sh <USER>

=head1 DESCRIPTION

Creates administrative user.

Requires C<sudo>.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__

