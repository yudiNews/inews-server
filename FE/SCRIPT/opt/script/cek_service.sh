#/bin/bash
HOST=$(hostname)
IPADDR=$(hostname -I)
chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ"

repinfo=$(redis-cli -a 1n3w5slaVE info replication | grep "master_link_status:up" | wc -l )
cekRDS=$(ps aux | grep redis | wc -l)
cek80=$(ps aux | grep nginx | grep -v "php-fpm"|wc -l)
cekPHP=$(ps aux | grep php-fpm | head -1 | awk '{print $11}' | awk -F":" '{print $1}')

echo "START TO CHECK SERVICE "

if [ $cek80 -gt 1 ]
   then
	echo "Normal"
   else
	echo "NGINX is DOWN"
	curl -s -F chat_id="$chat_id" -F text="WARNING!!! 
	$HOST $IPADDR Service NGINX is DOWN" https://api.telegram.org/bot$token/sendMessage > /dev/null
fi

if [ $cekPHP = "php-fpm" ]
   then
        echo "Normal"
   else
        echo "php is DOWN"
        curl -s -F chat_id="$chat_id" -F text="WARNING!!! 
	$HOST $IPADDR Service PHP FPM is DOWN" https://api.telegram.org/bot$token/sendMessage > /dev/null
fi

if [ $cekRDS -gt 1 ]
   then
	echo "Normal"
   else
	echo "REDIS is DOWN"
        curl -s -F chat_id="$chat_id" -F text="WARNING!!! 
	$HOST $IPADDR Service REDIS is DOWN" https://api.telegram.org/bot$token/sendMessage > /dev/null
fi

if [ $repinfo = 1 ]
   then
	echo "Normal"
   else
	echo "unsync"
        curl -s -F chat_id="$chat_id" -F text="WARNING!!! $HOST $IPADDR 
	REDIS unsync, please check" https://api.telegram.org/bot$token/sendMessage > /dev/null

fi
