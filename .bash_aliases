#echo [.bash_alises]

for i in `seq 1 16`
do
  alias f$i="fg %$i"
  alias b$i="bg %$i"
  alias d$i="pushd +$i"
done
alias h='history'
alias j='jobs -l'
alias d='dirs -v'
alias ls='ls --show-control-chars'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias pushd='pushd >/dev/null'
alias popd='popd >/dev/null'
alias nsl='nslookup'
alias fsb='fastboot'
alias heimdall='/c/winap/heimdall-suite-1.4.0/heimdall.exe'
alias cdl='cd `cds -r`'
#alias less='jless'
#alias lesskey='jlesskey'
#alias man='jman'
#alias cman='/usr/bin/man'
#alias ncftp='ncftp3'
#alias a2ps='a2ps-j -p -ns'
alias xd='od -A x -t x1'
#alias xd='hexdump -e '\''"%07.7_ax  " 16/1 "%02x " "\n" "%07.7_Ax\n"'\'
#alias xdc='hexdump -e '\''"%07.7_ax  " 16/1 "%_u " "\n" "%07.7_Ax\n"'\'
alias bdf='df'
#alias latex='jlatex'
#alias st='mst -q'
#alias uum='/usr/local/bin/Wnn4/uum'
#alias smbstat='smbstatus -s /etc/smb.conf'
alias wlan2='wifi connect wifi0 w2a_nomap'
alias wlan3='wifi connect wifi0 wlan3'
alias wlan4='wifi connect wifi0 wlan4'
alias wlan5='wifi connect wifi0 w5_nomap'
alias wlan6='wifi connect wifi0 wlan6'
alias wlan7='wifi connect wifi0 w7_nomap'
alias wlan8='wifi connect wifi0 w8_nomap'
alias wlan9='wifi connect wifi0 w9_nomap'
alias wlana='wifi connect wifi0 wa_nomap'
alias wlanb='wifi connect wifi0 wb_nomap'
alias wlanc='wifi connect wifi0 wc_nomap'
alias wfon='wifi connect wifi0 FON'
alias wlanany='wifi connect wifi0'
alias wlanoff='wifi connect wifi0'
alias emnet0='rasdial emnet0'
alias dialoff='rasdial /disc'
alias adbsysrw='adb shell mount -o remount,rw /dev/block/mmcblk0p1 /system'
alias adbsysro='adb shell mount -o remount,ro /dev/block/mmcblk0p1 /system'
alias prerootrw='ssh 192.168.2.3 -l root mount -o remount,rw /'
alias prerootro='ssh 192.168.2.3 -l root mount -o remount,ro /'

for i in pc1 pc2 npc2 pc3 wpc3 pc4 pc5 wpc5 pc6 pc7 npc8; do
  alias $i="ssh $i"
done
for i in 1 3 4 6 7; do
  alias $i="pc$i"
done
alias 2='npc2'
alias 8='npc8'
alias 5='wpc5'

# for BOW only
[ -n "$BOW" ] && {
  alias dos_lha=/dfs/c/bin/lha.exe
  alias mule=mule2
  alias ps='/bow/bowps.exe &'
  alias minimize='stty rows 0 columns 0'
  alias maximize='stty rows -1 columns -1'
  alias resize='stty rows -2 columns -2'
}

# for cygwin only
[ "$OSTYPE" = cygwin ] && {
  alias start='cygstart'
  alias xcacls='cscript c:\\winap\\bin\\xcacls.vbs'
  alias nvt='run /usr/local/bin/rxvt -e /bin/bash --login'
  #alias less='/usr/local/bin/less'
  #alias lessecho='/usr/local/bin/lessecho'
  #alias lesskey='/usr/local/bin/lesskey'
  alias lscpl='(cd /c/WINDOWS/system32; ls *.cpl)'
  alias lsmsc='(cd /c/WINDOWS/system32; ls *.msc)'
  alias hotplug='rundll32.exe shell32.dll,Control_RunDLL hotplug.dll &'
  alias xalan='java org.apache.xalan.xslt.Process'
  alias hv='xcygstart 1 /c/Program\ Files/HIDEMARU/Hidemaru.exe /r'
  alias hm='xcygstart /c/Program\ Files/HIDEMARU/Hidemaru.exe'
  alias hme='xcygstart 1 /c/Program\ Files/HIDEMARU/Hidemaru.exe /fe'
  alias hmj='xcygstart 1 /c/Program\ Files/HIDEMARU/Hidemaru.exe /fj'
  alias hms='xcygstart 1 /c/Program\ Files/HIDEMARU/Hidemaru.exe /fs'
  alias hmu='xcygstart 1 /c/Program\ Files/HIDEMARU/Hidemaru.exe /fu'
  alias hmub='xcygstart 1 /c/Program\ Files/HIDEMARU/Hidemaru.exe /fub'
  alias hmu8='xcygstart 1 /c/Program\ Files/HIDEMARU/Hidemaru.exe /fu8'
  alias lhmelt='xcygstart /c/Program\ Files/LHMELT/LHMELT.EXE'
  alias psh='powershell'
  alias cmv='cygstart /c/Program\ Files/BUFFALO/clientmgrv/bin/cmvMain.exe'
  alias wping='/c/Windows/System32/PING.EXE'
  alias sysprop='cygstart /c/windows/system32/SystemPropertiesAdvanced.exe'
}

unset i
