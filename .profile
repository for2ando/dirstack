# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

stty ixany
. $HOME/.environ
#biff y

. $HOME/lib/ssh-agent-ctl.sh
ssh-agent-ctl start
expr "`ssh-add -l`" : '.*no identities' >/dev/null && ssh-add
case `tty` in /dev/tty0)
  DISPLAY= cygstart "$HOME/etc/menus/t term/y2 privileged bash of Cygwin on rxvt.lnk"
;; esac
