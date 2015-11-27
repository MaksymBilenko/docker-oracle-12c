FROM sath89/oracle-12c-base

### This image is a build from non automated image cause of no possibility of Oracle 12c instalation in Docker container

ENV WEB_CONSOLE true

ADD entrypoint.sh /entrypoint.sh


EXPOSE 1521
EXPOSE 8080


ENTRYPOINT ["/entrypoint.sh"]
CMD [""]