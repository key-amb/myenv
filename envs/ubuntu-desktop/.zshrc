# load common shrc
. $MYENV_DIR/common/shrc.d/load_apps.shrc
. $MYENV_DIR/common/shrc.d/aliases

# Colors
autoload -U colors
colors

# auto completion
autoload -U compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # ignore case matching
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt auto_list  # list complementary items
setopt correct    # correct misspell
setopt auto_menu
setopt extended_glob

# cd & pushd
setopt auto_cd    # cd to directory with directory path only
#setopt auto_pushd # pushd when cd
setopt pushd_ignore_dups

# cdr
mkdir -p $HOME/.cache/shell
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

# history
setopt extended_history # record executed time to history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_ignore_space
setopt hist_reduce_blanks

## prompt
setopt prompt_subst

#tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt="%{${fg[cyan]}%}%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

PROMPT=$tmp_prompt
PROMPT2=$tmp_prompt2
RPROMPT=$tmp_rprompt
SPROMPT=$tmp_sprompt

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

unset tmp_prompt tmp_prompt2 tmp_rprompt tmp_sprompt

# vcs info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{magenta}%1v%f%F{green}[%~]%f|%F{green}[%~]%f)"

## custom PATH
PATH=$PATH:${MYENV_DIR}/common/bin

# remove duplicate PATH
typeset -U path PATH

############################################################
# extentional settings
if [ -d $HOME/.zshrc.d ]; then
  for file in `find $HOME/.zshrc.d -mindepth 1`; do
    source $file
  done
fi

# peco
. $MYENV_DIR/common/shrc.d/peco.zshrc

############################################################
# scripts to exec on login
update-local-repos

