#!/bin/bash
tgl=`date +%d%m%y`
prefix=$'NEWFE'
path=$'/opt/gdrive/'
pathsrc=$'/mainData/www/sites'
pathbkp=$'/opt/gdrive/'
gDriveID=$'19WZab9DwDowBelwK_3a2ldh8n0AX7BF1'
excl1=$'/mainData/www/sites/fw/storage'
HOST=$(hostname)
IPADDR=$(hostname -I)
chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ" 
echo "STARTING backup php"


 tar -czvf $path$prefix$tgl.tar.gz $pathsrc --exclude=$excl1 

if [ -e $path$prefix$tgl.tar.gz  ] 
then 
 echo ada file
echo uploading file to gdrive
 cd  $pathbkp && ./gdrive upload --parent $gDriveID $path$prefix$tgl.tar.gz
curl -s -F chat_id="$chat_id" -F text="Backup Coding From  $HOST $IPADDR 
has been successfully" https://api.telegram.org/bot$token/sendMessage > /dev/null
else
echo gak ada file
exit 0
fi

