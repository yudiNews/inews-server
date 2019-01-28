#!/bin/bash
tgl=`date +%d%m%y`
prefix=$'inewsDB'
host=$'10.10.32.105'
port=$'6339'
user=$'inews_cms'
pw=$'4pl1k451_n1h2018'
db=$'db_inews_portal'
path=$'/opt/gdrive/'
pathbkp=$'/opt/gdrive'
gDriveID=$'19WZab9DwDowBelwK_3a2ldh8n0AX7BF1'
echo "STARTING backup database"

backupDB()
{
	mysqldump -h $host -u $user -p$pw -P $port $db --skip-lock-tables > $path$prefix$tgl.sql
}

echo "backup database"
backupDB
sleep 2

compres_upload()
{
echo "check file and encrypt"
if [ -e $path$prefix$tgl.sql  ] 
then 
 echo ada file
 tar -czf $path$prefix$tgl.tar.gz $path$prefix$tgl.sql
echo uploading file to gdrive
 cd  $pathbkp && ./gdrive upload --parent $gDriveID $path$prefix$tgl.tar.gz
else
echo gak ada file
exit 0
fi
}

compres_upload

echo "removing sql file"
sleep 2
cari()
{
find $path -iname "*.sql"  -mtime +2 -exec rm -r {} \;
}
cari
#if [ -e $path$prefix$tgl.tar.gz ]
#then
# rm -f $path$prefix$tgl.sql
#else 
# exit 0
#fi
