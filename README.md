Oracle Standard Edition 12c Release 1
============================
[![](https://badge.imagelayers.io/sath89/oracle-12c:latest.svg)](https://imagelayers.io/?images=sath89/oracle-12c:latest 'Get your own badge on imagelayers.io')

Oracle Standard Edition 12c Release 1 on Ubuntu

This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/sath89/oracle-12c/) of [Docker Registry](https://registry.hub.docker.com/).

### Installation

    docker pull sath89/oracle-12c

Run with 8080 and 1521 ports opened:

    docker run -d -p 8080:8080 -p 1521:1521 sath89/oracle-12c

Run with data on host and reuse it:

    docker run -d -p 8080:8080 -p 1521:1521 -v /my/oracle/data:/u01/app/oracle sath89/oracle-12c

Connect database with following setting:

    hostname: localhost
    port: 1521
    sid: xe
    username: system
    password: oracle

Password for SYS & SYSTEM:

    oracle

Connect to Oracle Application Express web management console with following settings:

    http://localhost:8080/apex (TODO: Not yet implemented)
    workspace: INTERNAL
    user: ADMIN
    password: oracle

Connect to Oracle Enterprise Management console with following settings:

    http://localhost:8080/em
    user: sys
    password: oracle
    connect as sysdba: true


**In case of any issues please post it [here](https://github.com/MaksymBilenko/docker-oracle-12c/issues).**


