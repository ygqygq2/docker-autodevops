FROM docker.io/rockylinux:8

ENV SURREAL_VERSION=${SURREAL_VERSION} \
  LANG=en_US.UTF-8

LABEL maintainer="ygqygq2@qq.com" 

RUN yum -y install openssl curl findutils tar gzip unzip bash ca-certificates git bash-completion xmlstarlet tzdata jq \
  && yum clean all \
  && rm -rf /var/cache/yum \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && curl -sSf https://install.surrealdb.com | sh
