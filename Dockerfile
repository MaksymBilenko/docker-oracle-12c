FROM quay.io/maksymbilenko/oracle-12c-base:latest

### This image is a build from non automated image cause of no possibility of Oracle 12c instalation in Docker container

ENV WEB_CONSOLE true
ENV DBCA_TOTAL_MEMORY 2048
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/u01/app/oracle/product/12.2.0/SE/bin
ENV USE_UTF8_IF_CHARSET_EMPTY true
ENV ORACLE_HOME /u01/app/oracle/product/12.2.0/SE
ENV ORACLE_SID xe

ADD entrypoint.sh /entrypoint.sh

RUN yum install -y curl && yum clean all

EXPOSE 1521
EXPOSE 8080
VOLUME ["/docker-entrypoint-initdb.d"]

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
