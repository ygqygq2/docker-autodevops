FROM alpine:latest

ENV SURREAL_VERSION=${SURREAL_VERSION} \
  LANG=en_US.UTF-8

LABEL maintainer="ygqygq2@qq.com" 

RUN apk add --no-cache openssl curl tar gzip unzip bash ca-certificates git bash-doc bash-completion xmlstarlet tzdata jq \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && SURREAL_VERSION=${SURREAL_VERSION:-$(curl -s https://api.github.com/repos/surrealdb/surrealdb/releases/latest \
    | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')} \
  && curl -sSL "https://github.com/surrealdb/surrealdb/releases/download/${SURREAL_VERSION}/surreal-${SURREAL_VERSION}.linux-amd64.tgz" | tar zx \
  && chmod a+x surreal \
  && mv surreal /usr/bin/

CMD ["cat"]
