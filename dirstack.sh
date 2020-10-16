## dirsave/dirload command library
## usage: source dirsave.sh

export DIRSTACKFILE
DIRSTACKFILE="$HOME/.dirstack"

dirsave() {
  dirs -p -l >"$DIRSTACKFILE"
}

dirload() {
  dirs -c
  {
    read dir || return
    cd "$dir"
    while read dir
    do
      pushd "$dir" >/dev/null
      pushd +1 >/dev/null
    done
  } <"$DIRSTACKFILE"
}
