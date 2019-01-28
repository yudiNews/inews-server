#/bin/bash
HOST=$(hostname)
IPADDR=$(hostname -I)
chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ"

repinfo=$(redis-cli -a 1n3w5slaVE info replication | grep "master_link_status:up" | wc -l )

echo "START TO CHECK SERVICE "

if [ $repinfo = 1 ]
   then
	echo "Normal"
   else
	echo "unsync"
        curl -s -F chat_id="$chat_id" -F text="WARNING!!! $HOST $IPADDR 
	REDIS unsync, please check" https://api.telegram.org/bot$token/sendMessage > /dev/null

fi
