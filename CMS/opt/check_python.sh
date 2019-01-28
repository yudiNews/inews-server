#!/bin/bash
chat_id=$"-261791836"
token=$"722372111:AAH8QfWBtD9xx-M5X2xDfJJzUx7ZoXzbRUQ"
msg=$"Scheduler CMS Down"


input=$(ps aux | grep python | grep sched_update.py | wc -l)
if [ $input = 1 ]
then
        exit 0
else
        curl -s -F chat_id="$chat_id" -F text="$msg" https://api.telegram.org/bot$token/sendMessage > /dev/null
        echo $msg | mail -s "WARNING CMS" yudi.ariestya@mncgroup.com,thoriq.nur@mncgroup.com,fajar.pratama@mncgroup.com,elfani.egotypalas@mncgroup.com
fi

