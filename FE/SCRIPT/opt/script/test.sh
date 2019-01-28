#!/bin/bash

TOTAL=$(free -m | grep Mem | awk '{print $2}')
USED=$(free -m | grep Mem | awk '{print $3}')
FREE=$(free -m | grep Mem | awk '{print $4}')
BUFFCACHE=$(free -m | grep Mem | awk '{print $6}')
#TOTALUSED=$($USED + $BUFFCACHE)

let "totalused = $USED + $BUFFCACHE"

let "persen = $totalused * 100 / $TOTAL"



echo total=$TOTAL
echo $totalused
echo memory = $persen"%"







