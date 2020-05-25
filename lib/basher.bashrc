# bash

BASHER_BUNDLE_PACKAGES=(
  progrhyme/git-wraps
  progrhyme/bash-git-push-carefully
  progrhyme/toolbox
  progrhyme/gcloud-prompt
  progrhyme/sh-pathctl
)

basher_bundle_install() {
  local bp
  for bp in ${BASHER_BUNDLE_PACKAGES[@]}; do
    basher install $bp
  done
}
