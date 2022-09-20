## Dockerfile
FROM centos:7

LABEL maintainer "29ygq@sina.com"

ARG TENGINE_VERSION

ENV TENGINE_VERSION="${TENGINE_VERSION:-2.3.3}" \
  TENGINE_BASEDIR="/usr/local/nginx"

#get all the dependences and nginx
RUN yum install -y git gcc make wget pcre pcre-devel openssl openssl-devel \
  && rm -rf /var/cache/yum/* \
  && groupadd -g 1001 www \
  && useradd -u 1001 -g www -s /sbin/nologin www \
  && mkdir -p ${TENGINE_BASEDIR}/tmp \
  && mkdir -p ${TENGINE_BASEDIR}/conf/vhost \
  && chown www ${TENGINE_BASEDIR}/tmp

WORKDIR /tmp

## comile tengine
# tengine url: http://tengine.taobao.org/download/tengine-${TENGINE_VERSION}.tar.gz
RUN wget http://tengine.taobao.org/download/tengine-${TENGINE_VERSION}.tar.gz \
  && tar -zxf tengine-${TENGINE_VERSION}.tar.gz \
  && cd tengine-${TENGINE_VERSION} \
  && ./configure --prefix=${TENGINE_BASEDIR} --user=www --group=www \
  && make \
  && make install \
  && ln -s ${TENGINE_BASEDIR}/sbin/nginx /usr/bin/ \
  && ln -sf /dev/stdout ${TENGINE_BASEDIR}/logs/access.log \
  && ln -sf /dev/stderr ${TENGINE_BASEDIR}/logs/error.log \
  && chown www -R ${TENGINE_BASEDIR}/html \
  && rm -rf tengine-${TENGINE_VERSION} tengine-${TENGINE_VERSION}.tar.gz


EXPOSE 8080

COPY nginx.conf ${TENGINE_BASEDIR}/conf/

WORKDIR ${TENGINE_BASEDIR}/conf

CMD ["nginx", "-g", "daemon off;"]
