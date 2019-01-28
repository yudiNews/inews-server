#!/bin/bash
tgl=`date +%d%m%y`
prefix=$'cms'
path=$'/home/backup/'
pathsrc=$'/mainData/cms/sites'
pathbkp=$'/home/yudi/gdrive/'
gDriveID=$'19WZab9DwDowBelwK_3a2ldh8n0AX7BF1'
excl1=$'/mainData/cms/sites/logs'
excl2=$'/mainData/cms/sites/app/webroot/files'
excl3=$'/mainData/cms/sites/app/webroot/cache'
echo "STARTING backup php"


 tar -czvf $path$prefix$tgl.tar.gz $pathsrc --exclude=$excl1 --exclude=$excl2 --exclude=$excl3

if [ -e $path$prefix$tgl.tar.gz  ] 
then 
 echo ada file
echo uploading file to gdrive
 cd  $pathbkp && ./gdrive upload --parent $gDriveID $path$prefix$tgl.tar.gz
else
echo gak ada file
exit 0
fi

