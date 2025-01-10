FROM alpine:latest

LABEL maintainer "ygqygq2@qq.com"

# 多个版本用逗号分隔
ARG NODE_VERSION_TO_INSTALL

ENV NODE_VERSION_TO_INSTALL=${NODE_VERSION_TO_INSTALL:-"--lts"} \
  LANG=en_US.UTF-8 \
  NVM_DIR=/root/.nvm

#RUN sed -i 's|https://dl-cdn.alpinelinux.org/alpine|https://mirrors.aliyun.com/alpine|g' /etc/apk/repositories

RUN apk add -U openssl curl tar gzip unzip ca-certificates git bash bash-doc bash-completion \
  python3 gcc g++ make xmlstarlet tzdata jq skopeo \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && rm -rf /var/cache/apk/*

# 安装必要的工具
RUN apk update && apk upgrade && \
  apk add --no-cache bash curl ca-certificates wget netcat-openbsd tzdata jq && \
  cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  echo "Asia/Shanghai" >/etc/timezone && \
  ln -sf /bin/bash /bin/sh

# 安装 NVM
RUN mkdir -p $NVM_DIR && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash -x && \
  echo "Installed NVM"

# 安装指定版本的 Node.js
RUN . $NVM_DIR/nvm.sh && \
  for version in $(echo $NODE_VERSION_TO_INSTALL | tr "," "\n"); do \
    nvm install $version; \
  done

RUN /bin/bash

CMD ["sleep", "Infinity"]
