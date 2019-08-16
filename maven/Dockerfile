# https://hub.docker.com/r/_/maven/
FROM maven:3.6.0-jdk-8-alpine

LABEL maintainer "29ygq@sina.com"

RUN apk add -U xmlstarlet bash bash-doc bash-completion \
  && rm -rf /var/cache/apk/* \
  && ln -sf /bin/bash /bin/sh \
  && /bin/bash
