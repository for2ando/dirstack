## A dirstack command library for bash
## usage: source dirstack.sh

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
