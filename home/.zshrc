# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Setup completion system
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Load term colors
autoload -Uz colors; colors

setopt autopushd
setopt nocaseglob nomatch
setopt menucomplete
setopt extendedhistory histignoredups histignorespace incappendhistory
setopt notify
setopt promptsubst
setopt nobeep

#==============
# Env variables
#==============

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1

path=($path /usr/local/sbin $(brew --prefix coreutils)/libexec/gnubin)
export EDITOR='vim'
export LESS='-giMRw -z-4'

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#========
# Aliases
#========

alias reload="exec $SHELL -i"
alias editconfig="$EDITOR ~/.zshrc && reload"

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy='/usr/libexec/PlistBuddy'

alias g='git'

LS_OPTIONS='-FG' # show symbol at end and show color

alias ls="command ls $LS_OPTIONS"
alias ll='ls -hl'
alias la='ls -Ahl'

alias bi='brew install'
alias bs='brew search'
alias bu='brew update && brew upgrade'
alias cask='brew cask'
alias ci='brew cask install'
alias cs='brew cask search'

#==========
# Functions
#==========

togglefiles() {
  # pass -y to relaunch Finder automatically
  current="$(defaults read com.apple.finder AppleShowAllFiles)"
  new="YES"

  if [[ "$current" == "$new" ]]; then
    new="NO"
  fi

  defaults write com.apple.finder AppleShowAllFiles $new
  [[ "$1" == "-y" ]] || read -q '?Relaunch Finder now [Yn]? ' relaunch

  if [[ "$relaunch" == "y" ]]; then
    killall Finder /System/Library/CoreServices/Finder.app
  fi
}

source ~/.zprompt

if [[ -f ~/.extra ]]; then
  source ~/.extra
fi
