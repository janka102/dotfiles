if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER='open'
fi

export EDITOR='vim'
export VISUAL=$EDITOR
export PAGER='less'

if [[ -z "$LANG" ]]; then
    export LANG='en_US.UTF-8'
fi

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
    /usr/local/{bin,sbin}
    ~/bin
    $path
)

# Set the list of directories that Zsh searches for completions.
fpath=(
    $HOME/.homesick/repos/homeshick/completions
    $fpath
)

# Set the default Less options.
# Other options include -X (disable screen clearing on exit)
# and -F (exit if the content fits on one screen).
export LESS='-g -i -M -R -S -w -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
    export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

# Temporary Files

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi