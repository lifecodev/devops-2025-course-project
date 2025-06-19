FROM centos:8

RUN  yum -y update && \
     yum -y -q install epel-release centos-release-scl && \
     yum -y -q update

RUN rpm --import https://repo.quantom.info/qhb/keys/RPM-GPG-KEY-qhb
RUN yum-config-manager --add-repo https://repo.quantom.info/qhb/std-1/centos/8/x86_64/qhb.repo
RUN yum install -y qcp

RUN cp /etc/qcp/config-example.yaml \
       /etc/qcp/config.yaml

ENTRYPOINT ["qcp"]
