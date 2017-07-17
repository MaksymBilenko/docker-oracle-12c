FROM sath89/oracle-12c-base

### This image is a build from non automated image cause of no possibility of Oracle 12c instalation in Docker container

ENV WEB_CONSOLE true
ENV DBCA_TOTAL_MEMORY 2048
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/u01/app/oracle/product/12.1.0/xe/bin
ENV USE_UTF8_IF_CHARSET_EMPTY true

ADD entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get -y install curl && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 

EXPOSE 1521
EXPOSE 8080
VOLUME ["/docker-entrypoint-initdb.d"]

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
