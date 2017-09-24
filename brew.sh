#!/usr/bin/env bash

########################################################
# Install Homebrew if needed, then install some formulae
########################################################

echo '=============================================='
echo '=            Setting up Homebrew             ='
echo '=============================================='
echo ''

# If Homebrew is not installed, then download, review, and install
if ! command -v brew >/dev/null 2>&1; then
  echo 'Installing Homebrew...'
  cd $(mktemp -d)
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install -o install_brew
  echo 'Opening homebrew install file'
  echo 'Review, edit, save, and exit'
  read -p 'Any key to continue' -n 1 -s
  nano install_brew

  echo ''
  read -p 'OK to install homebrew [Yn]? ' -n 1

  if [[ ! "$REPLY" =~ ^[Yy]?$ ]]; then
    exit 0 
  fi

  echo ''
  /usr/bin/ruby install_brew
else
  echo 'Homebrew already installed, updating...'
fi

# Just make sure we’re using the latest Homebrew
brew update
brew upgrade

# Install formulae

echo 'Installing terminal programs...'
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`
brew install bash coreutils openssl zsh                            # system stuff
brew install clang-format git git-town htop node sshfs             # things used often to kinda often
brew install imagemagick optipng p7zip wget # things used not so often

if ! fgrep -q '/usr/local/bin/zsh' /etc/shells; then
  echo 'Switching shell to newly installed zsh... requires sudo:'
  echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/zsh
fi

echo 'Installing fonts...'
brew tap caskroom/fonts
brew cask install font-fira-code font-source-code-pro-for-powerline

echo 'Installing GUI apps via cask...'
brew cask install android-platform-tools firefox flux google-chrome
brew cask install gpgtools iterm2 java keepingyouawake osxfuse slack
brew cask install spotify usb-overdrive visual-studio-code vlc

# Install quicklook plugins
brew cask install qlcolorcode qlstephen suspicious-package

# Force reloading Quicklook Generators list
qlmanage -r

# Remove outdated versions from the cellar
brew cleanup
