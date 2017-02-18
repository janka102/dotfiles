#!/usr/bin/env bash

echo '=============================================='
echo '=            Setting up dotfiles             ='
echo '=============================================='
echo ''
echo 'Copying dotfiles to home directory...'
read -p 'FILES MAY GET OVERWRITTEN, are you sure [yN]? ' -n 1
echo ''

if [[ "$REPLY" =~ ^[yY]$ ]]; then
  rsync --exclude .DS_Store -avh ./home/ ~/
fi

read -p 'Setup Homebrew [yN]? ' -n 1
echo ''

if [[ "$REPLY" =~ ^[yY]$ ]]; then
  bash ./brew.sh
fi

read -p 'Setup the SKS Keyserver certificate for GPG [yN]? ' -n 1
echo ''

if [[ "$REPLY" =~ ^[yY]$ ]]; then
  echo 'Downloading certificate...'
  curl https://sks-keyservers.net/sks-keyservers.netCA.pem -o ~/Downloads/hkps.pool.sks-keyservers.net.pem
  echo ''
  echo 'Needs manual verification of fingerprint for ~/Downloads/hkps.pool.sks-keyservers.net.pem'
  echo 'Please visit https://sks-keyservers.net/verify_tls.php, snippet below...'
  echo 'Downloading fingerprint snippet...'
  curl https://sks-keyservers.net/verify_tls.php | grep -o 'The fingerprint.*</b>'
  open ~/Downloads

  read -p 'Do you want to install the certificate [yN]? ' -n 1
  echo ''

  if [[ "$REPLY" =~ ^[yY]$ ]]; then
    mkdir -p /usr/local/etc/openssl/certs
    mv ~/Downloads/hkps.pool.sks-keyservers.net.pem /usr/local/etc/openssl/certs
  fi
else
  echo '** You should change the keyserver options in ~/.gnupg/gpg.conf'
fi

read -p 'Setup macOS defaults [yN]? ' -n 1
echo ''

if [[ "$REPLY" =~ ^[yY]$ ]]; then
  bash ./defaults.sh
fi
