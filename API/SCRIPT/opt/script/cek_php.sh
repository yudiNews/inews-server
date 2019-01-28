#/bin/bash
HOST=$(hostname)
IPADDR=$(hostname -I)
chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ"

cekPHP=$(ps aux | grep php-fpm | head -1 | awk '{print $11}' | awk -F":" '{print $1}')

echo "START TO CHECK SERVICE "

cekPHP()
{
if [ $cekPHP = "php-fpm" ]
   then
        echo "Normal"
   else
        echo "php is DOWN"
        curl -s -F chat_id="$chat_id" -F text="WARNING!!! $HOST $IPADDR Service PHP FPM is DOWN" https://api.telegram.org/bot$token/sendMessage > /dev/null
fi
}
cekPHP
