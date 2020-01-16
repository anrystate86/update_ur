#!/bin/bash

# ps aux | grep unregulated-reporting.jar | grep -v grep | awk '{print $11}'

if [ $# -eq 0 ] || [ $# -gt 1 ]
then
echo "Using script:"
echo "update_ur.sh http://some_site.ru/update_file.zip"
exit 1
fi

# ps aux | grep unregulated-reporting.jar | grep -v grep | awk '{print $11}'
#Temp dir name
tdn=$(date "+%Y%m%d%H%M")
urhome=/oracle/noportal
urfile=unregulated-reporting.jar

#mkdir $nohome/temp/$tdn
mkdir /tmp/$tdn
cd /tmp/$tdn

mkdir /tmp/$tdn/backup
mkdir /tmp/$tdn/unzip

echo $1
file=$(echo $1 | sed 's|.*/||')


wget $1 --no-check-certificate
unzip $file -d /tmp/$tdn/unzip

cd $urhome
sh shutdown.sh

mv "$urhome/$urfile" "/tmp/$tdn/backup/"
cp -rf /tmp/$tdn/unzip/* $urhome/

#cd $urhome

nohup ./run.sh &
#tail -f ./nohup.out
sleep 5

if [ -n $(ps aux | grep unregulated-reporting.jar | grep -v grep) ]
then
echo "Something goes wrong look in ./launcher/app.log ./launcher/portal.log"
exit 1
fi

exit 0
