#!/bin/bash

TOTAL=$(free -m | grep Mem | awk '{print $2}')
USED=$(free -m | grep Mem | awk '{print $3}')
FREE=$(free -m | grep Mem | awk '{print $4}')
BUFFCACHE=$(free -m | grep Mem | awk '{print $6}')
export DIR="/opt/script"
log_stat=$(cat $DIR/st_mem.log)
HOST=$(hostname)
IPADDR=$(hostname -I)
chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ"
let "totalused = $USED + $BUFFCACHE"
let " persen = $totalused * 100 / $TOTAL"
STATUS=80

notify()
{
echo WARNING - $HOST
echo memory = $persen"%"
echo ip $IPADDR
 if [ $persen -gt $STATUS ]
   then
curl -s -F chat_id="$chat_id" -F text="WARNING!!! $HOST $IPADDR
memory $persen%" https://api.telegram.org/bot$token/sendMessage > /dev/null
 else
 curl -s -F chat_id="$chat_id" -F text="STATUS NORMAL $HOST $IPADDR
memory $persen%" https://api.telegram.org/bot$token/sendMessage > /dev/null
fi
}

check()
{
  if [ $persen -le $STATUS ] && [ $log_stat = 0 ]; then
     sync; echo 1 > /proc/sys/vm/drop_caches
           echo 0 > $DIR/st_mem.log
        elif [ $persen -gt $STATUS ] && [ $log_stat -eq 0 ];then
                sync; echo 1 > /proc/sys/vm/drop_caches
                      echo 1 > $DIR/st_mem.log
                        notify
        elif [ $persen -gt $STATUS ] && [ $log_stat -eq 1 ];then
                sync; echo 2 > /proc/sys/vm/drop_caches
                      echo 2 > $DIR/st_mem.log
                        notify
        elif [ $persen -gt $STATUS ] && [ $log_stat -eq 2 ];then
                sync; echo 3 > /proc/sys/vm/drop_caches
                      echo 3 > $DIR/st_mem.log
                        notify
        elif [ $persen -lt $STATUS ] && [ $log_stat > 0 ];then
                        echo 0 > $DIR/st_mem.log
                        notify
        else
                exit 1
fi

}

check
