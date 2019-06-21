FROM docker:stable-git
LABEL maintainer "29ygq@sina.com"
RUN apk add -U --no-cache \
   bash \
   bash-doc \
   bash-completion \
   xmlstarlet \
   && rm -rf /var/cache/apk/* \
   && /bin/bash
