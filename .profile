#echo [.profile]

stty ixany
. $HOME/.environ
#biff y

. $HOME/lib/ssh-agent-ctl.sh
ssh-agent-ctl start
expr "`ssh-add -l`" : '.*no identities' >/dev/null && ssh-add
case `tty` in /dev/tty0)
  DISPLAY= cygstart "$HOME/etc/menus/t term/y2 privileged bash of Cygwin on rxvt.lnk"
;; esac
