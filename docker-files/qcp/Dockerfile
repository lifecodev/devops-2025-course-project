FROM centos:7
RUN  sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo  && \
     sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo  && \
     sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo  && \
     sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*  && \
     sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*


RUN  yum -y update && \
     yum -y -q install epel-release centos-release-scl && \

RUN rpm --import https://repo.quantom.info/qhb/keys/RPM-GPG-KEY-qhb
RUN yum-config-manager --add-repo https://repo.quantom.info/qhb/std-1/centos/7/x86_64/qhb.repo

RUN  sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo  && \
     sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo  && \
     sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo  && \
     sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*  && \
     sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum install -y qcp

RUN cp /etc/qcp/config-example.yaml \
       /etc/qcp/config.yaml

ENTRYPOINT ["qcp"]
