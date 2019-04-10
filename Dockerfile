FROM quay.io/maksymbilenko/oracle-12c-base:latest

### This image is a build from non automated image cause of no possibility of Oracle 12c instalation in Docker container

ENV WEB_CONSOLE true
ENV DBCA_TOTAL_MEMORY 1024

ADD entrypoint.sh /entrypoint.sh


EXPOSE 1521
EXPOSE 8080
VOLUME ["/u01/app/oracle"]
VOLUME ["/docker-entrypoint-initdb.d"]

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
