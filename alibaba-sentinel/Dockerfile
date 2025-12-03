# Sentinel Dashboard Docker Image
# https://github.com/alibaba/Sentinel

ARG JAVA_VERSION=17

FROM eclipse-temurin:${JAVA_VERSION}-jre

# Declare ARG after FROM to use in RUN
ARG SENTINEL_VERSION

LABEL maintainer="ygqygq2" \
  description="Alibaba Sentinel Dashboard"

# Create sentinel user and group
RUN groupadd -r sentinel && useradd -r -g sentinel sentinel

# Set working directory
WORKDIR /home/sentinel

# Download sentinel dashboard jar
RUN if [ -z "${SENTINEL_VERSION}" ]; then \
      SENTINEL_VERSION=$(wget -qO- -t5 -T10 "https://api.github.com/repos/alibaba/Sentinel/releases/latest" \
      | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'); \
    fi \
  && wget -q https://github.com/alibaba/Sentinel/releases/download/${SENTINEL_VERSION}/sentinel-dashboard-${SENTINEL_VERSION}.jar \
  -O sentinel-dashboard.jar \
  && chown -R sentinel:sentinel /home/sentinel

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget -q --spider http://localhost:${SENTINEL_DASHBOARD_SERVER_PORT:-8080}/health || exit 1

# Switch to non-root user
USER sentinel

# Expose default port
EXPOSE 8080

# Environment variables
ENV JAVA_OPTS="-Xms256m -Xmx512m" \
  SENTINEL_DASHBOARD_AUTH_USERNAME=sentinel \
  SENTINEL_DASHBOARD_AUTH_PASSWORD=sentinel \
  SENTINEL_DASHBOARD_SERVER_PORT=8080

# Default command to start sentinel dashboard
CMD ["sh", "-c", "java ${JAVA_OPTS} \
  -Dserver.port=${SENTINEL_DASHBOARD_SERVER_PORT} \
  -Dsentinel.dashboard.auth.username=${SENTINEL_DASHBOARD_AUTH_USERNAME} \
  -Dsentinel.dashboard.auth.password=${SENTINEL_DASHBOARD_AUTH_PASSWORD} \
  -jar sentinel-dashboard.jar"]
