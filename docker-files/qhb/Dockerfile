FROM centos:8

RUN  yum -y update && \
     yum -y -q install epel-release centos-release-scl && \
     yum -y -q update

RUN rpm --import https://repo.quantom.info/qhb/keys/RPM-GPG-KEY-qhb
RUN yum-config-manager --add-repo https://repo.quantom.info/qhb/std-1/centos/8/x86_64/qhb.repo
RUN yum install -y qhb-core qhb-contrib

COPY ./scripts/server.sh /server.sh
COPY ./scripts/run.sh /run.sh

ENV PGDATA="/qhb-data/" \
    DB_SOCKETS_PATH="/qhb-dbsocket/" \
    PATH="/usr/local/qhb/bin/:${PATH}"

RUN mkdir -p "$PGDATA" "$DB_SOCKETS_PATH" && \
    chown qhb:qhb "$PGDATA" "$DB_SOCKETS_PATH"

VOLUME ["$PGDATA", "$DB_SOCKETS_PATH"]

ENTRYPOINT ["/server.sh"]
