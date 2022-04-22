#!/bin/bash
function start() {
/sbin/unbound -dd -vvv -c /var/lib/chroot/etc/unbound.conf
}

function stop() {
  /bin/unbound-control stop
}

function restart() {
  stop
  start
}

function reload() {
  /bin/unbound-control reload
}

function status() {
  /bin/unbound-control status
}

function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

if [ $# -lt 1 ]
then
  echo "Usage : $0 start|stop|restart|reload|status"
  exit
fi

case "$1" in
  start)    function_exists start && start
          ;;
  stop)  function_exists stop && stop
          ;;
  restart)  function_exists restart && restart
          ;;
  reload)  function_exists reload && reload
          ;;
  status)  function_exists status && status
          ;;  
  *)      echo "Invalid command - Valid->start|stop|restart|reload|status"
          ;;
esac