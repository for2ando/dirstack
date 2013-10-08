# ~/.bash_profile: executed by bash for login shells.

export bash_profile=1
export etc_profile=1

. $HOME/lib/dirstack.sh
dirload

if [ -r ~/.profile ] ; then
  . ~/.profile
fi

if [ -r ~/.bashrc -a -z "$bashrc" ] ; then
  . ~/.bashrc
fi
