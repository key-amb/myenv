MYENV_DIR=$HOME/.myenv

# Change directory color when type 'ls --color'. See man dircolors.
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
# Use rbenv
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
# Use plenv
if [ -d $HOME/.plenv ]; then
  export PATH="$HOME/.plenv/bin:$PATH"
fi

## history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
