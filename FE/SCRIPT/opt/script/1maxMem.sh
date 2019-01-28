#!/bin/bash

TOTAL=$(free -m | grep Mem | awk '{print $2}')
USED=$(free -m | grep Mem | awk '{print $3}')
FREE=$(free -m | grep Mem | awk '{print $4}')
BUFFCACHE=$(free -m | grep Mem | awk '{print $6}')
chat_id=$"-365446783"
token=$"676897181:AAHu0AO0H49A4ICtTieiBbAe617270EUntk"
export DIR="/opt/script"
log_stat=$(cat $DIR/st_mem.log)
HOST=$(hostname)
IPADDR=$(hostname -I)
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
 curl -s -F chat_id="$chat_id" -F text="NORMAL $HOST $IPADDR
memory $persen%" https://api.telegram.org/bot$token/sendMessage > /dev/null
fi
}

check()
{
  if [ $persen -le $STATUS ] && [ $log_stat = 0 ]; then
#     sync; echo 1 > /proc/sys/vm/drop_caches
           echo 0 > $DIR/st_mem.log
	echo 1
        elif [ $persen -gt $STATUS ] && [ $log_stat -eq 0 ];then
#                sync; echo 1 > /proc/sys/vm/drop_caches
                      echo 1 > $DIR/st_mem.log
			notify
			echo 2
        elif [ $persen -gt $STATUS ] && [ $log_stat -eq 1 ];then
#                sync; echo 2 > /proc/sys/vm/drop_caches
                      echo 2 > $DIR/st_mem.log
			notify
			echo 3
        elif [ $persen -gt $STATUS ] && [ $log_stat -eq 2 ];then
#                sync; echo 3 > /proc/sys/vm/drop_caches
                      echo 3 > $DIR/st_mem.log
                        notify
                        echo 4
        elif [ $persen -lt $STATUS ] && [ $log_stat > 0 ];then
    			echo 0 > $DIR/st_mem.log
			notify
			echo 5
	else
		echo "eksit"
		exit 1	
fi

}

check

