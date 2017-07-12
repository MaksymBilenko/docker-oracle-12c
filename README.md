Oracle Standard Edition 12c Release 1
============================

[![](https://badge.imagelayers.io/sath89/oracle-12c:latest.svg)](https://imagelayers.io/?images=sath89/oracle-12c:latest 'Get your own badge on imagelayers.io')

Oracle Standard Edition 12c Release 1 on Ubuntu
This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/sath89/oracle-12c/) of [Docker Registry](https://registry.hub.docker.com/).

[![asciicast](https://asciinema.org/a/45878.png)](https://asciinema.org/a/45878)

### Installation

    docker pull sath89/oracle-12c

Run with 8080 and 1521 ports opened:

    docker run -d -p 8080:8080 -p 1521:1521 sath89/oracle-12c

Run with data on host and reuse it:

    docker run -d -p 8080:8080 -p 1521:1521 -v /my/oracle/data:/u01/app/oracle sath89/oracle-12c

Run with Custom DBCA_TOTAL_MEMORY (in Mb):

    docker run -d -p 8080:8080 -p 1521:1521 -v /my/oracle/data:/u01/app/oracle -e DBCA_TOTAL_MEMORY=1024 sath89/oracle-12c

Connect database with following setting:

    hostname: localhost
    port: 1521
    sid: xe
    service name: xe
    username: system
    password: oracle

To connect using sqlplus:

<pre>
sqlplus system/oracle@//localhost:1521/xe
</pre>

Password for SYS & SYSTEM:

    oracle

Connect to Oracle Application Express web management console with following settings:

    http://localhost:8080/apex
    workspace: INTERNAL
    user: ADMIN
    password: 0Racle$

Apex upgrade up to v 5.*

    docker run -it --rm --volumes-from ${DB_CONTAINER_NAME} --link ${DB_CONTAINER_NAME}:oracle-database -e PASS=YourSYSPASS sath89/apex install
Details could be found here: https://github.com/MaksymBilenko/docker-oracle-apex

Connect to Oracle Enterprise Management console with following settings:

    http://localhost:8080/em
    user: sys
    password: oracle
    connect as sysdba: true

By Default web management console is enabled. To disable add env variable:

    docker run -d -e WEB_CONSOLE=false -p 1521:1521 -v /my/oracle/data:/u01/app/oracle sath89/oracle-12c
    #You can Enable/Disable it on any time

Start with additional init scripts or dumps:

    docker run -d -p 1521:1521 -v /my/oracle/data:/u01/app/oracle -v /my/oracle/init/SCRIPTSorSQL:/docker-entrypoint-initdb.d sath89/oracle-12c
    
By default Import from `docker-entrypoint-initdb.d` is enabled only if you are initializing database (1st run).

To customize dump import use `IMPDP_OPTIONS` env variable like `-e IMPDP_OPTION="REMAP_TABLESPACE=FOO:BAR"`
To run import at any case add `-e IMPORT_FROM_VOLUME=true`

**In case of using DMP imports dump file should be named like ${IMPORT_SCHEME_NAME}.dmp**

**User credentials for imports are  ${IMPORT_SCHEME_NAME}/${IMPORT_SCHEME_NAME}**

If you have an issue with database init like DBCA operation failed, please reffer to this [issue](https://github.com/MaksymBilenko/docker-oracle-12c/issues/16)

**TODO LIST**

* Web management console HTTPS port
* Add functionality to run custom scripts on startup, for example User creation
* Add Parameter that would setup processes amount for database (Currently by default processes=300)
* Spike with clustering support
* Spike with DB migration from 11g

**In case of any issues please post it [here](https://github.com/MaksymBilenko/docker-oracle-12c/issues).**


