#!/bin/bash
set -e

# Prevent owner issues on mounted folders
chown -R oracle:dba /u01/app/oracle
rm -f /u01/app/oracle/product
ln -s /u01/app/oracle-product /u01/app/oracle/product

#Run Oracle root scripts
/u01/app/oraInventory/orainstRoot.sh > /dev/null 2>&1
echo | /u01/app/oracle/product/12.1.0/xe/root.sh > /dev/null 2>&1 || true

case "$1" in
	'')
		#Check for mounted database files
		if [ "$(ls -A /u01/app/oracle/oradata)" ]; then
			echo "found files in /u01/app/oracle/oradata Using them instead of initial database"
			echo "XE:$ORACLE_HOME:N" >> /etc/oratab
			chown oracle:dba /etc/oratab
			chown 664 /etc/oratab
			rm -rf /u01/app/oracle-product/12.1.0/xe/dbs
			ln -s /u01/app/oracle/dbs /u01/app/oracle-product/12.1.0/xe/dbs
			#Startup Database
			su oracle -c "/u01/app/oracle/product/12.1.0/xe/bin/tnslsnr &"
			su oracle -c 'echo startup\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba'
		else
			echo "Database not initialized. Initializing database."

			#printf "Setting up:\nprocesses=$processes\nsessions=$sessions\ntransactions=$transactions\n"

			mv /u01/app/oracle-product/12.1.0/xe/dbs /u01/app/oracle/dbs
			ln -s /u01/app/oracle/dbs /u01/app/oracle-product/12.1.0/xe/dbs

			echo "Starting tnslsnr"
			su oracle -c "/u01/app/oracle/product/12.1.0/xe/bin/tnslsnr &"
			#create DB for SID: xe
			su oracle -c "$ORACLE_HOME/bin/dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname xe.oracle.docker -sid xe -responseFile NO_VALUE -characterSet AL32UTF8 -totalMemory $DBCA_TOTAL_MEMORY -emConfiguration LOCAL -pdbAdminPassword oracle -sysPassword oracle -systemPassword oracle"
			
			echo "Configuring Apex console"
			cd $ORACLE_HOME/apex
			su oracle -c 'echo -e "0Racle$\n8080" | $ORACLE_HOME/bin/sqlplus -S / as sysdba @apxconf > /dev/null'
			su oracle -c 'echo -e "${ORACLE_HOME}\n\n" | $ORACLE_HOME/bin/sqlplus -S / as sysdba @apex_epg_config_core.sql > /dev/null'
			su oracle -c 'echo -e "ALTER USER ANONYMOUS ACCOUNT UNLOCK;" | $ORACLE_HOME/bin/sqlplus -S / as sysdba > /dev/null'
			echo "Database initialized. Please visit http://#containeer:8080/em http://#containeer:8080/apex for extra configuration if needed"
		fi

		if [ $WEB_CONSOLE == "true" ]; then
			echo 'Starting web management console'
			su oracle -c 'echo EXEC DBMS_XDB.sethttpport\(8080\)\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba'
		else
			echo 'Disabling web management console'
			su oracle -c 'echo EXEC DBMS_XDB.sethttpport\(0\)\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba'
		fi

		echo "Database ready to use. Enjoy! ;)"

		##
		## Workaround for graceful shutdown.
		##
		while [ "$END" == '' ]; do
			sleep 1
			trap "su oracle -c 'echo shutdown immediate\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba'" INT TERM
		done
		;;

	*)
		echo "Database is not configured. Please run '/entrypoint.sh' if needed."
		$@
		;;
esac
