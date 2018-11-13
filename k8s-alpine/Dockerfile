FROM alpine:latest

LABEL maintainer "29ygq@sina.com"

ENV KUBE_VERSION="v1.12.1" \
  HELM_VERSION="v2.11.0"

# https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl
RUN apk add -U openssl curl tar gzip bash ca-certificates git \
  && curl -L -o /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
  && curl -L -O https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk \
  && apk add glibc-2.28-r0.apk \
  && rm glibc-2.28-r0.apk \
  && curl https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/bin/kubectl \
  && curl "https://kubernetes-helm.storage.googleapis.com/helm-${HELM_VERSION}-linux-amd64.tar.gz" | tar zx \
  && mv linux-amd64/helm /usr/bin/ \
  && mv linux-amd64/tiller /usr/bin/ 

ENTRYPOINT ["helm"]
# ENTRYPOINT ["tiller"]
# ENTRYPOINT ["kubectl"]
CMD ["version --client"]
