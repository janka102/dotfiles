# dotfiles

My dotfiles for terminal environment. Also includes `brew.sh` to install Homebrew and some formulae, and `defaults.sh` to setup macOS with my preferred settings.

## Install

```bash
git clone git@github.com:janka102/dotfiles.git
cd dotfiles
bash ./install.sh
# Follow prompts
```

Example `~/.extra`:

```sh
# Git credentials
GIT_AUTHOR_NAME=""
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"

GIT_AUTHOR_EMAIL=""
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```
