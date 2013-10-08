# User dependent .bashrc file

export bashrc=1
if [ -r /etc/profile -a -z "$etc_profile" ] ; then
  . /etc/profile
fi
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
elif [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

#stty -ixon
#
# Don't wait for job termination notification
#set -o notify
#
# Don't put duplicate lines in the history.
#export HISTCONTROL=ignoredups
#
# Some example functions
#function settitle() { echo -n "^[]2;$@^G^[]1;$@^G"; }

if [ -n "$EMACS" ]; then
    PS1='\n\u@\h \w\n$ '
fi

if [ -z "$environ" ]; then
  . $HOME/.environ
fi

alias ls='ls --show-control-chars'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias h='history'
alias j='jobs -l'
alias d='dirs'
alias pd=pushd
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
do
  alias f$i="fg %$i"
  alias b$i="bg %$i"
  alias d$i="pushd +$i"
done
#alias less='less -r'
#alias whence='type -a'

[ -n "$BOW" ] && {
  SHELL=$BASH
  alias dos_lha=/dfs/c/dosap/bin/lha.exe
  alias mule=mule2
  alias ps='/bow/bowps.exe &'
  alias minimize='stty rows 0 columns 0'
  alias maximize='stty rows -1 columns -1'
  alias resize='stty rows -2 columns -2'
  alias xd='hexdump -e '\''"%07.7_ax" 16/1 "  %02x" "\n" "%07.7_Ax\n"'\'
}

[ "$OSTYPE" = cygwin ] && {
  #alias less='/usr/local/bin/less'
  #alias lessecho='/usr/local/bin/lessecho'
  #alias lesskey='/usr/local/bin/lesskey'
  alias hm='start /c/winap/hidemaru/Hidemaru.exe'
  alias hmu='start /c/winap/hidemaru/Hidemaru.exe /fu8'
  alias hv='start /c/winap/hidemaru/Hidemaru.exe /r'
  alias lh='start /c/Program\ Files/LHMELT/LHMELT.EXE'
  #alias start='cmd /c start'
  alias start='cygstart'
  alias xd='od -A x -t x1'
  alias psman='powershell -command man'
  alias psh='powershell'
}

if [ "$CWD" != "" ]; then
  cd "$CWD"
  unset CWD
fi
