#/bin/bash
HOST=$(hostname)
IPADDR=$(hostname -I)
chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ"

echo "START TO CHECK DB "
cekDB=$(curl http://localhost/cek.php| awk '{print $1}')

if [ $cekDB = "failed" ]
then
	echo "WARNING..."
	curl -s -F chat_id="$chat_id" -F text="WARNING!!! DETECTED DOWN 
	FORM $HOST $IPADDR" https://api.telegram.org/bot$token/sendMessage > /dev/null
else
	echo "OK..."
fi
