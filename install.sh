#!/usr/bin/env bash

echo '=============================================='
echo '=            Setting up dotfiles             ='
echo '=============================================='
echo ''
echo 'Copying dotfiles to home directory...'
read -p 'FILES MAY GET OVERWRITTEN, are you sure [yN]? ' -n 1
echo ''

if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  rsync --exclude .DS_Store -avh ./home/ ~/
fi

read -p 'Do you want to setup Homebrew [yN]? ' -n 1
echo ''

if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  bash ./brew.sh
fi

read -p 'Do you want to setup macOS defaults [yN]? ' -n 1
echo ''

if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  bash ./defaults.sh
fi
