#!/bin/bash

chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ"
#token=$"676897181:AAHu0AO0H49A4ICtTieiBbAe617270EUntk"
#chat_id=$"-365446783"

ID=$2
input2=$1
PARAM='purge debug'
purging()
  {
   grep -lr $ID /var/log/nginx/cache/ | xargs rm -f

  }

CEK()
  {
   grep -lr $ID /var/log/nginx/cache/
   grep -lr $ID /var/log/nginx/cache/ | wc -l
  }
#purging
#CEK
for name in $PARAM
do
if [ $name = $input2 ]
   then
        if [ -z $ID ] || [ -z $name ]
             then
                echo "Parameter $0 belum lengkap"
        elif [ $input2 = "debug" ]
             then
                CEK
        elif [ $input2 = "purge" ]
             then
                purging
                curl -s -F chat_id="$chat_id" -F text="MANUALLY PURGING FOR ID:$ID
                HAS BEEN SUCCESSFULLY" https://api.telegram.org/bot$token/sendMessage > /dev/null

                echo proses purging
   else
        exit 0
        #echo kosong
fi
        fi
done


