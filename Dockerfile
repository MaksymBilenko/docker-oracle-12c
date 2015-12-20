FROM sath89/oracle-12c-base

### This image is a build from non automated image cause of no possibility of Oracle 12c instalation in Docker container

ENV WEB_CONSOLE true
ENV DBCA_TOTAL_MEMORY 512

ADD entrypoint.sh /entrypoint.sh


EXPOSE 1521
EXPOSE 8080
VOLUME ["/u01/app/oracle"]

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
