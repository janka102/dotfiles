# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

fpath=($HOME/.homesick/repos/homeshick/completions $fpath)