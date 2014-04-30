# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

if [ -f .zprompt ]; then
    source .zprompt
fi

if [ -f .zalias ]; then
    source .zalias
fi