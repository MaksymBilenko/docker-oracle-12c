FROM quay.io/maksymbilenko/oracle-12c-base:latest

### This image is a build from non automated image cause of no possibility of Oracle 12c instalation in Docker container

ENV WEB_CONSOLE true
ENV DBCA_TOTAL_MEMORY 4096
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/u01/app/oracle/product/12.2.0/SE/bin
ENV DISPLAY :0
ENV VNC_PASSWORD oracle
ENV MANUAL_DBCA false
ENV ORACLE_HOME /u01/app/oracle/product/12.2.0/SE
ENV ORACLE_SID xe

RUN yum install -y epel-release && yum --enablerepo=epel -y install tigervnc-server novnc python-websockify numpy curl xorg-x11-server-Xvfb.x86_64 xterm x11vnc novnc && yum clean all

EXPOSE 1521
EXPOSE 8080
EXPOSE 6800
VOLUME ["/docker-entrypoint-initdb.d"]

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
