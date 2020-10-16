# .bash_profile

. $HOME/lib/dirstack.sh
dirload

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}dirsave"
