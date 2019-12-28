FROM alpine:3.11.2

LABEL maintainer "29ygq@sina.com"

ENV KUBE_VERSION="v1.13.4" \
  HELM_VERSION="v2.13.0"

# https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl
RUN apk add -U openssl curl tar gzip bash ca-certificates git bash bash-doc bash-completion xmlstarlet tzdata \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && curl -L -o /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
  && curl -L -O https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk \
  && apk add glibc-2.28-r0.apk \
  && rm glibc-2.28-r0.apk \
  && curl https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
  && chmod +x /usr/bin/kubectl \
  && curl "https://kubernetes-helm.storage.googleapis.com/helm-${HELM_VERSION}-linux-amd64.tar.gz" | tar zx \
  && mv linux-amd64/helm /usr/bin/ \
  && mv linux-amd64/tiller /usr/bin/ \
  && rm -rf /var/cache/apk/* \
  && /bin/bash

CMD ["sleep", "Infinity"]
