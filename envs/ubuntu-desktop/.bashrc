# load common shrc
. $MYENV_ROOT/common/shrc.d/load_apps.shrc
. $MYENV_ROOT/common/shrc.d/aliases
. $MYENV_ROOT/submodule/sh-pathctl/pathctl.shrc

## custom PATH
PATH=.:$PATH
PATH=$PATH:${MYENV_ROOT}/common/bin

# remove duplicate PATH
pathctl_uniq

############################################################
# extentional settings
if [[ -d $HOME/.bashrc.d ]]; then
  for file in `find $HOME/.bashrc.d -mindepth 1`; do
    . $file
  done
fi

############################################################
# scripts to exec on login
update-local-repos

