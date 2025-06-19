FROM centos:7

RUN  sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo  && \
     sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo  && \
     sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo  && \
     sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*  && \
     sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN  yum -y update && \
     yum -y install epel-release centos-release-scl

RUN rpm --import https://repo.quantom.info/qhb/keys/RPM-GPG-KEY-qhb
RUN yum-config-manager --add-repo https://repo.quantom.info/qhb/std-1/centos/7/x86_64/qhb.repo
RUN  sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo  && \
     sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo  && \
     sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo  && \
     sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*  && \
     sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum install -y qhb-core qhb-contrib

COPY ./scripts/server.sh /server.sh
COPY ./scripts/run.sh /run.sh

ENV PGDATA="/qhb-data/" \
    DB_SOCKETS_PATH="/qhb-dbsocket/" \
    PATH="/usr/local/qhb/bin/:${PATH}"

RUN mkdir -p "$PGDATA" "$DB_SOCKETS_PATH" && \
    chown qhb:qhb "$PGDATA" "$DB_SOCKETS_PATH"
RUN chmod +x /server.sh
RUN chmod +x /run.sh

VOLUME ["$PGDATA", "$DB_SOCKETS_PATH"]

ENTRYPOINT ["/server.sh"]
