FROM alpine:latest

LABEL maintainer "29ygq@sina.com"

ARG KUBE_VERSION
ARG HELM_VERSION

ENV KUBE_VERSION=${KUBE_VERSION} \
    HELM_VERSION=${HELM_VERSION} \
    LANG=en_US.UTF-8

# https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl
RUN apk add -U openssl curl tar gzip unzip bash ca-certificates git bash bash-doc bash-completion xmlstarlet tzdata jq \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && curl -L -o /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
  && GLIBC_VERSION=$(wget -qO- -t5 -T10 "https://api.github.com/repos/sgerrand/alpine-pkg-glibc/releases/latest" \
  | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g') \
  && curl -L -O https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
  && apk add glibc-${GLIBC_VERSION}.apk \
  && rm glibc-${GLIBC_VERSION}.apk \
  && rm -rf /var/cache/apk/*

RUN echo "${KUBE_VERSION}" "${HELM_VERSION}"

RUN if [ -z "${KUBE_VERSION}" ]; then \
      KUBE_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt); \
    fi \ 
  && if [ -z "${HELM_VERSION}" ]; then \
      HELM_VERSION=$(wget -qO- -t5 -T10 "https://api.github.com/repos/helm/helm/releases/latest" \
      | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'); \
    fi \
  && curl -LO "https://dl.k8s.io/release/${KUBE_VERSION}/bin/linux/amd64/kubectl" \
  && chmod a+x kubectl \
  && mv kubectl /usr/bin/ \
  && curl "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" | tar zx \
  && mv linux-amd64/helm /usr/bin/ 

RUN /bin/bash

CMD ["sleep", "Infinity"]
