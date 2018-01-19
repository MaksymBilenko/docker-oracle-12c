FROM ubuntu:latest

MAINTAINER Maksym Bilenko "sath891@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

ENV ORACLE_HOME /u01/app/oracle/product/12.1.0/my_sid
ENV ORACLE_SID my_sid

RUN apt-get update && apt-get install make unzip vim wget telnet libaio1 -y && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* \
    && ln -s /usr/bin/awk /bin/awk \
    && groupadd --gid 1001 dba && groupadd -g 54421 oinstall && useradd -u 54321 -g oinstall -G dba oracle

# Download your oracle12c v2 zip file from http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html and put beside this Dockerfile
ADD linuxx64_12201_database.zip /
ADD install.sh /
ADD oracle-12c-ee.rsp /

RUN unzip linuxx64_12201_database.zip -d /home/oracle && rm /linuxx64_12201_database.zip && echo "Sleep to relax" && sleep 5 && ./install.sh && rm -r /home/oracle/database
