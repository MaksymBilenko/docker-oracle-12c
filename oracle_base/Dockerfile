FROM centos:7

RUN yum install -y wget unzip binutils.x86_64 compat-libcap1.x86_64 gcc.x86_64 gcc-c++.x86_64 glibc.i686 glibc.x86_64 \
glibc-devel.i686 glibc-devel.x86_64 ksh compat-libstdc++-33 libaio.i686 libaio.x86_64 libaio-devel.i686 libaio-devel.x86_64 \
libgcc.i686 libgcc.x86_64 libstdc++.i686 libstdc++.x86_64 libstdc++-devel.i686 libstdc++-devel.x86_64 libXi.i686 libXi.x86_64 \
libXtst.i686 libXtst.x86_64 make.x86_64 sysstat.x86_64 && yum clean all

ENV ORACLE_DATABASE_DOWNLOAD_URL https://www.dropbox.com/s/maex8fu98o6j0xj/linuxx64_12201_database.zip?dl=0

ADD install /install

RUN /install/oracle_12c_install.sh /install/oracle-12c-se.rsp

RUN mv /u01/app/oracle/product /u01/app/oracle-product

