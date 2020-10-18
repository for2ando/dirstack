# .bash_profile

. $HOME/lib/dirstack.sh

test -z "$DIRSTACKFILE" && DIRSTACKFILE="$HOME/.dirstack"
export DIRSTACKFILE

dirload

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}dirsave"
