#/bin/bash
HOST=$(hostname)
IPADDR=$(hostname -I)
chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ"

cek80=$(ps aux | grep nginx | awk 'NR-1 {print $1}' | head -1)

echo "START TO CHECK SERVICE "
cekNGINX()
{
if [ $cek80 = "nginx" ]
   then
	echo "Normal"
   else
	echo "NGINX is DOWN"
	curl -s -F chat_id="$chat_id" -F text="WARNING!!! $HOST $IPADDR Service NGINX is DOWN" https://api.telegram.org/bot$token/sendMessage > /dev/null
fi
}

cekNGINX
