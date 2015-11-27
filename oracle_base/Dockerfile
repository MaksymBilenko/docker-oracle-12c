FROM     ubuntu:latest

MAINTAINER Maksym Bilenko "sath891@gmail.com"

ENV	DEBIAN_FRONTEND	noninteractive

ENV ORACLE_HOME		/u01/app/oracle/product/12.1.0/xe
ENV ORACLE_SID 		xe

RUN apt-get update && apt-get install libaio1 -y && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 
RUN ln -s /usr/bin/awk /bin/awk

RUN groupadd --gid 1001 dba && useradd -g dba -m --uid 1001 oracle

ADD oracle-12c.tar.gz /
