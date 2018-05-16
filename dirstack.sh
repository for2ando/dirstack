## dirsave/dirload command library
## usage: source dirsave.sh

dirsave() {
  dirs -p -l >$HOME/.dirstack
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
  } <$HOME/.dirstack
}
