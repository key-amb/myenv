if which peco >/dev/null 2>&1; then
  # unbind for peco
  bindkey -r '^u'

  # search history
  function peco-select-history() {
    local tac
    if which tac > /dev/null; then
      tac="tac"
    else
      tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | eval $tac | peco)
    CURSOR=$#BUFFER
    zle clear-screen
  }
  zle -N peco-select-history
  bindkey '^r' peco-select-history

  # search repository
  __repos="$HOME/gitrepos $HOME/my/repo $HOME/my/go/src"
  function peco-cd-repository() {
    DIR=$(\find ${__repos} -type d -a \! -regex '.*/\.git.*' | peco | head -n 1)
    pushd $DIR > /dev/null
    zle clear-screen
  }
  function peco-find-repository() {
    local l=$(\find ${__repos} -a \! -regex '.*/\.git.*' | peco)
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
  }
  zle -N peco-cd-repository
  zle -N peco-find-repository
  bindkey '^ud' peco-cd-repository
  bindkey '^uf' peco-find-repository

  # search current directory
  function peco-find() {
    local l=$(\find . -maxdepth 8 -a \! -regex '.*/\..*' | peco)
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
  }
  function peco-find-all() {
    local l=$(\find . -maxdepth 8 | peco)
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
  }
  zle -N peco-find
  zle -N peco-find-all
  bindkey '^uc' peco-find
  bindkey '^ua' peco-find-all
fi
