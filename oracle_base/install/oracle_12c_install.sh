#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "No rsp file specified"
    exit 1
elif [ ! -f $1 ]; then
	echo "Can't find RSP file $1"
	exit 1
fi

#sysctl workaround
echo 'exit 0' > /usr/sbin/sysctl

groupadd dba && useradd -m -G dba oracle
mkdir /u01 && chown oracle:dba /u01 && chmod 775 /u01

#Download oracle database zip
echo "Downloading oracle database zip"
wget -q -O /oracle_database.zip "$ORACLE_DATABASE_DOWNLOAD_URL"

echo "Extracting oracle database zip"
su oracle -c 'unzip -q /oracle_database.zip -d /home/oracle/'
rm -f /oracle_database.zip

#Run installer
su oracle -c "cd /home/oracle/database && ./runInstaller -skipPrereqs -silent -responseFile $1 -waitForCompletion"
#Cleanup
echo "Cleaning up"
rm -rf /home/oracle/database /tmp/*

#Move product to custom location
mv /u01/app/oracle/product /u01/app/oracle-product