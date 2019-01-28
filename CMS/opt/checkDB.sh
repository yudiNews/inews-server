#!/bin/bash
host=$'10.10.32.45'
port=$'3307'
user=$'inews_cms'
pw=$'4pl1k451_n1h2018'
db=$'db_inews_portal'
chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ"
msg=$"DB - CMS Down"

check()
{
DBEXISTS=$(mysql -h $host -u $user -p$pw -P $port --batch --skip-column-names -e "SHOW DATABASES LIKE '"$db"';" | grep "$db" > /dev/null; echo "$?")
if [ $DBEXISTS -eq 0 ];then
    echo "normal, $db already exists. exiting"
else
    curl -s -F chat_id="$chat_id" -F text="$msg" https://api.telegram.org/bot$token/sendMessage > /dev/null
#    echo $msg | mail -s "WARNING - database DOWN" yudi.ariestya@mncgroup.com,thoriq.nur@mncgroup.com,fajar.pratama@mncgroup.com,elfani.egotypalas@mncgroup.com

    exit;
fi
}
check

