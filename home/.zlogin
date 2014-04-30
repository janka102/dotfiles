# Print a random, hopefully interesting, adage.
if (( $+commands[fortune] )); then
  fortune -a -s
  print
fi

