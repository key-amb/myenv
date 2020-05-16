export MYENV=centos
MYENV_ROOT=$HOME/.myenv

PS1="\[\e[0;33m\]\u@\h:\[\e[0m\]\[\e[0;34m\]\w%\[\e[0m\] "

if [[ -f ~/.bashrc ]]; then
  . ~/.bashrc
fi

## history
HISTSIZE=1000
SAVEHIST=1000
HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  '
