#!/usr/bin/env bash

set -euo pipefail

TECH_NOTES_DIR=${TECH_NOTES_DIR:-$HOME/my/repos/tech-notes}
HUGO_PORT=${HUGO_PORT:-1313}
HUGO_OPTIONS=${HUGO_OPTIONS:-}

if [[ -z "$HUGO_OPTIONS" ]]; then
  HUGO_OPTIONS=(--disableFastRender)
fi
HUGO_OPTIONS+=(--port $HUGO_PORT)

if ss -nlt | grep "\b${HUGO_PORT}\b" &>/dev/null; then
  echo "[info] localhost:$HUGO_PORT is already in use. Do nothing."
  exit 0
fi

cd $TECH_NOTES_DIR
nohup hugo server ${HUGO_OPTIONS[@]} &>> /tmp/hugo-server.tech-notes.$(date +'%Y%m%d').log &

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<run-tech-notes-hugo-server.sh> - Run hugo server on tech-notes directory

=head1 SYNOPSYS

    ./run-tech-notes-hugo-server.sh

=head1 DESCRIPTION

blah blah blah.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>progrhyme@gmail.comE<gt>

=head1 LICENSE

The MIT License (MIT)

Copyright (c) 2020 IKEDA Kiyoshi

=cut

__EOF__

