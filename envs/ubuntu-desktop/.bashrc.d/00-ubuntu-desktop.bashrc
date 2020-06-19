# load common shrc
source $DOTS_ROOT/shrc.d/load_apps.shrc
_SHELP_INCLUDES=(sh-pathctl:pathctl.shrc)
source $DOTS_ROOT/shrc.d/load_shelp.shrc
source $DOTS_ROOT/shrc.d/aliases
source $DOTS_ROOT/bashrc.d/load_enhancd.bashrc

## custom PATH
PATH=".:$HOME/bin:$PATH"

# remove duplicate PATH
pathctl_uniq

############################################################
# scripts to exec on login
update-local-repos
