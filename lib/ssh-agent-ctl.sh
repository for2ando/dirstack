ssh-agent-ctl() {
  local specfile progname
  readonly progname=ssh-agent-ctl 
  [ $# -le 0 ] && { echo "usage: $progname {start|stop|load|clean}"; return; }
  readonly specfile=$HOME/.ssh/agent
  #exist_process() { [ -n "$1" ] && ps -p "$1" >/dev/null 2>&1; }
  exist_process() { [ -n "$1" ] && ps | fgrep "$1" >/dev/null 2>&1; }
  exist_socket() { [ -n "$1" -a -S "$1" ]; }

  while true; do
    case "$1" in
    start)
      [ -n "$SSH_CLIENT" ] && exist_socket $SSH_AUTH_SOCK && break
      exist_process $SSH_AGENT_PID && exist_socket $SSH_AUTH_SOCK && break
      exist_process $SSH_AGENT_PID && { eval `ssh-agent -k`; rm -f $specfile; }
      exist_socket $SSH_AUTH_SOCK && rm -f "$SSH_AUTH_SOCK"
      [ -r $specfile ] && {
        . $specfile >/dev/null
        exist_process $SSH_AGENT_PID && exist_socket $SSH_AUTH_SOCK && break
        exist_process $SSH_AGENT_PID && { eval `ssh-agent -k`; rm -f $specfile; }
        exist_socket $SSH_AUTH_SOCK && rm -f "$SSH_AUTH_SOCK"
      }
      ssh-agent >$specfile || { echo "$progname: ssh-agent failed.">&2; break; }
      . $specfile >/dev/null
      ;;
    stop)
      [ -n "$SSH_AGENT_PID" ] && { eval `ssh-agent -k`; rm -f $specfile; }
      ;;
    load|reload)
      [ -r $specfile ] && . $specfile >/dev/null
      ;;
    clean)
      exist_process $SSH_AGENT_PID && { eval `ssh-agent -k`; rm -f $specfile; }
      exist_socket $SSH_AUTH_SOCK && rm -f "$SSH_AUTH_SOCK"
      ;;
    *)
      echo "$progname: $1: no such directive.">&2
      ;;
    esac
    break
  done
  unset exist_process exist_socket
}
