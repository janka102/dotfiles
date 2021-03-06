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

IS_MACOS="$([[ `uname -s` == 'Darwin' ]] && printf '1')"

# Env variables
#==============================================================================#

# macOS only
if [[ -n "$IS_MACOS" ]]; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_INSECURE_REDIRECT=1

  path=($path /usr/local/sbin $(brew --prefix coreutils)/libexec/gnubin)

elif [[ -d ~/.local/bin ]]; then
  path=($path ~/.local/bin)
fi

export NVM_DIR="$HOME/.nvm"
export EDITOR='vim'
export LESS='-FgiMR -z-4'

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Aliases
#==============================================================================#

LS_OPTIONS='-Fh' # show symbol at end and human readable sizes

# macOS only
if [[ -n "$IS_MACOS" ]]; then
  # PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
  alias plistbuddy='/usr/libexec/PlistBuddy'

  # Homebrew
  alias bi='brew install'
  alias bI='brew info'
  alias bs='brew search'
  alias bu='brew update && brew upgrade'
  alias cask='brew cask'
  alias ci='brew cask install'
  alias cI='brew cask info'
  alias cs='brew cask search'

  # FTP
  alias startftp='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
  alias stopftp='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'

  LS_OPTIONS="$LS_OPTIONS -G" # show color
else
  LS_OPTIONS="$LS_OPTIONS --color"

  alias open="xdg-open"
fi

alias l="ls $LS_OPTIONS"
alias ll="ls $LS_OPTIONS -l"
alias la="ls $LS_OPTIONS -Al"
alias g='git'
alias reload="exec $SHELL -i"
alias editconfig="$EDITOR ~/.zshrc && reload"

# Functions
#==============================================================================#

mkcd() {
  mkdir -p "$1" && cd "$1"
}

tempcd() {
  cd "$(mktemp -d '/tmp/temp.XXXX')"
}

if [ -s "$NVM_DIR/nvm.sh" ]; then
  # This lazy loads actual nvm, node, npm, and npx because the load time for nvm is so long
  # If one is called, the others are loaded too
  lazy_load_nvm() {
    unset -f lazy_load_nvm

    unset -f nvm
    unset -f node
    unset -f npm
    unset -f npx
    source "$NVM_DIR/nvm.sh"
  }
  nvm() {
    lazy_load_nvm
    nvm "$@"
  }
  node() {
    lazy_load_nvm
    node "$@"
  }
  npm() {
    lazy_load_nvm
    npm "$@"
  }
  npx() {
    lazy_load_nvm
    npx "$@"
  }
fi

# macOS only
if [[ -n "$IS_MACOS" ]]; then
  togglefiles() {
    # pass -y to relaunch Finder automatically
    current="$(defaults read com.apple.finder AppleShowAllFiles)"
    new='YES'

    if [[ "$current" == "$new" ]]; then
      new='NO'
    fi

    defaults write com.apple.finder AppleShowAllFiles $new
    [[ "$1" == '-y' ]] || read -q '?Relaunch Finder now [Yn]? ' relaunch

    if [[ "$relaunch" == 'y' ]]; then
      killall Finder /System/Library/CoreServices/Finder.app
    fi
  }
fi

# Other files
#==============================================================================#

for file in ~/.{zprompt,extra,zprofile}; do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done