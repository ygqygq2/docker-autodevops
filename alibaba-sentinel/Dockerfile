# Sentinel Dashboard Docker Image
# https://github.com/alibaba/Sentinel

ARG JAVA_VERSION=17

# Auto-select Java version based on Sentinel version
# Recommended: Sentinel < 1.8.6 use JDK 11, Sentinel >= 1.8.6 use JDK 17
FROM eclipse-temurin:${JAVA_VERSION}-jre

# Declare ARG after FROM to use in RUN
ARG SENTINEL_VERSION

LABEL maintainer="ygqygq2" \
  description="Alibaba Sentinel Dashboard"

# Create sentinel user and group
RUN groupadd -r sentinel && useradd -r -g sentinel sentinel

# Set working directory
WORKDIR /home/sentinel

# Download sentinel dashboard jar and auto-select Java version based on Sentinel version
RUN set -ex \
  && if [ -z "${SENTINEL_VERSION}" ]; then \
      SENTINEL_VERSION=$(wget -qO- -t5 -T10 "https://api.github.com/repos/alibaba/Sentinel/releases/latest" \
      | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'); \
    fi \
  && echo "Using Sentinel version: ${SENTINEL_VERSION}" \
  && wget -q https://github.com/alibaba/Sentinel/releases/download/${SENTINEL_VERSION}/sentinel-dashboard-${SENTINEL_VERSION}.jar \
  -O sentinel-dashboard.jar \
  && echo "${SENTINEL_VERSION}" > /home/sentinel/VERSION

# Copy entrypoint script
COPY --chown=sentinel:sentinel entrypoint.sh /
RUN chmod +x /entrypoint.sh

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
CMD ["/entrypoint.sh"]
