FROM ubuntu:latest AS builder

LABEL maintainer "ygqygq2@qq.com"

# 多个版本用逗号分隔
ARG NODE_VERSION_TO_INSTALL

ENV NODE_VERSION_TO_INSTALL=${NODE_VERSION_TO_INSTALL:-"--lts"} \
LANG=en_US.UTF-8 \
NVM_DIR=/root/.nvm

RUN apt-get update && apt-get install -y \
  curl \
  ca-certificates \
  git \
  bash \
  build-essential \
  python3 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY install-node.sh .
RUN chmod +x /app/install-node.sh && /bin/bash install-node.sh "${NODE_VERSION_TO_INSTALL}"

FROM ubuntu:latest

ENV LANG=en_US.UTF-8 \
  NVM_DIR=/root/.nvm

# 安装必要的工具
RUN apt-get update && apt-get install -y \
  bash \
  curl \
  ca-certificates \
  wget \
  tzdata \
  jq \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && ln -sf /bin/bash /bin/sh \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY install-node.sh .
RUN chmod +x /app/install-node.sh && /bin/bash install-node.sh
COPY --from=builder /root/.nvm/versions /root/.nvm/versions

RUN /bin/bash

CMD ["sleep", "Infinity"]
