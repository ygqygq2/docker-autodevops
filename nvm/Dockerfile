FROM alpine:latest AS builder

LABEL maintainer "ygqygq2@qq.com"

# 多个版本用逗号分隔
ARG NODE_VERSION_TO_INSTALL

ENV NODE_VERSION_TO_INSTALL=${NODE_VERSION_TO_INSTALL:-"--lts"} \
LANG=en_US.UTF-8 \
NVM_DIR=/root/.nvm

#RUN sed -i 's|https://dl-cdn.alpinelinux.org/alpine|https://mirrors.aliyun.com/alpine|g' /etc/apk/repositories

RUN apk add -U openssl curl tar gzip unzip ca-certificates git bash bash-doc bash-completion \
python3 gcc g++ make linux-headers \
&& rm -rf /var/cache/apk/*

WORKDIR /app
COPY install-node.sh .
RUN chmod +x /app/install-node.sh && /bin/bash install-node.sh "${NODE_VERSION_TO_INSTALL}"

FROM alpine:latest

ENV LANG=en_US.UTF-8 \
  NVM_DIR=/root/.nvm

# 安装必要的工具
RUN apk update && apk upgrade && \
apk add --no-cache bash curl ca-certificates wget netcat-openbsd tzdata jq && \
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
echo "Asia/Shanghai" >/etc/timezone && \
ln -sf /bin/bash /bin/sh

WORKDIR /app
COPY install-node.sh .
RUN chmod +x /app/install-node.sh && /bin/bash install-node.sh
COPY --from=builder /root/.nvm/versions /root/.nvm/versions

RUN /bin/bash

CMD ["sleep", "Infinity"]
