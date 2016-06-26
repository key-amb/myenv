#!/usr/bin/env bash

set -euo pipefail

MYENV=ubuntu-desktop
ADMIN=${ADMIN:-$USER}
BASE_DIR=$HOME/.myenv

. $BASE_DIR/lib/setup.bashrc
. $BASE_DIR/lib/package/dpkg.bashrc

install_docker() {
  # Prepare apt repository
  sudo apt-get update
  install_pkg apt-transport-https ca-certificates
  sudo apt-key adv \
    --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  sudo sh -c \
    "echo deb https://apt.dockerproject.org/repo ubuntu-xenial main > /etc/apt/sources.list.d/docker.list"
  sudo apt-get update
  sudo apt-get purge lxc-docker

  install_pkg linux-image-extra-$(uname -r)

  install_pkg docker-engine
}

admin_to_docker_group() {
  (grep docker /etc/group | grep $ADMIN) &>/dev/null && return
  sudo usermod -aG docker $ADMIN
}

if dpkg-query -l docker-engine >/dev/null 2>&1; then
  echo "[info] docker is already installed."
else
  install_docker
fi

admin_to_docker_group

src=files/systemd/docker/service.conf
dst=/etc/systemd/system/docker.service.d/service.conf
if diff -u $THE_ENV_DIR/$src $dst >/dev/null 2>&1; then
  echo "[info] No difference: $src to $dst"
else
  SUDO_SYNC=1
  sync_file $src $dst
  echo "[notice] Restart docker"
  sudo systemctl restart docker
fi

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-docker.sh> - 

=head1 SYNOPSYS

    setup-docker.sh

=head1 DESCRIPTION

blah blah blah.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__

