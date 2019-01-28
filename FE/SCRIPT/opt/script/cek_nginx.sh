#/bin/bash
HOST=$(hostname)
IPADDR=$(hostname -I)
chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ"

cek80=$(ps aux | grep nginx | grep -v "php-fpm"|wc -l)

echo "START TO CHECK SERVICE "

if [ $cek80 -gt 1 ]
   then
	echo "Normal"
   else
	echo "NGINX is DOWN"
	curl -s -F chat_id="$chat_id" -F text="WARNING!!! 
	$HOST $IPADDR Service NGINX is DOWN" https://api.telegram.org/bot$token/sendMessage > /dev/null
fi
