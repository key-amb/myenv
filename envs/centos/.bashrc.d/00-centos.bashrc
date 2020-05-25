# load common shrc
. $MYENV_ROOT/common/shrc.d/load_apps.shrc
. $MYENV_ROOT/common/shrc.d/load_basher.shrc
. $MYENV_ROOT/common/shrc.d/aliases
. $MYENV_ROOT/submodule/sh-pathctl/pathctl.shrc

## custom PATH
PATH=".:$HOME/bin:$PATH"
PATH="$PATH:${MYENV_ROOT}/common/bin"

# remove duplicate PATH
pathctl_uniq

### enhancd + peco
if [[ -d $MYENV_ROOT/submodule/enhancd ]]; then
  ENHANCD_HYPHEN_ARG="-ls"
  ENHANCD_DOT_ARG="-up"
  ENHANCD_DISABLE_HOME=1
  . $MYENV_ROOT/submodule/enhancd/init.sh
  bind -x '"\C-ur": cd -ls'
  PECO_CD_CMD=__enhancd::cd
fi

############################################################
# scripts to exec on login
update-local-repos
