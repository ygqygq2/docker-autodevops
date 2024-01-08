ARG BASE_IMAGE

FROM ${BASE_IMAGE:-mysql:8.0}

LABEL maintainer "ygqygq2@qq.com"

COPY entrypoint /

ENTRYPOINT ["/entrypoint"]
