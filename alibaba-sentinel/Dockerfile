# Sentinel Dashboard Docker Image
# https://github.com/alibaba/Sentinel

ARG JAVA_VERSION=17
FROM eclipse-temurin:${JAVA_VERSION}-jre-alpine

LABEL maintainer="ygqygq2" \
  description="Alibaba Sentinel Dashboard" \
  version="1.8.9"

# Sentinel version
ARG SENTINEL_VERSION=1.8.9

# Create sentinel user and group
RUN addgroup -S sentinel && adduser -S sentinel -G sentinel

# Set working directory
WORKDIR /home/sentinel

# Download sentinel dashboard jar
RUN wget -q https://github.com/alibaba/Sentinel/releases/download/${SENTINEL_VERSION}/sentinel-dashboard-${SENTINEL_VERSION}.jar \
  -O sentinel-dashboard.jar \
  && chown sentinel:sentinel sentinel-dashboard.jar

# Switch to non-root user
USER sentinel

# Expose default port
EXPOSE 8080

# Environment variables
ENV JAVA_OPTS="-Xms256m -Xmx512m" \
  SENTINEL_DASHBOARD_AUTH_USERNAME=sentinel \
  SENTINEL_DASHBOARD_AUTH_PASSWORD=sentinel \
  SENTINEL_DASHBOARD_SERVER_PORT=8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget -q --spider http://localhost:${SENTINEL_DASHBOARD_SERVER_PORT}/health || exit 1

# Default command to start sentinel dashboard
CMD ["sh", "-c", "java ${JAVA_OPTS} \
  -Dserver.port=${SENTINEL_DASHBOARD_SERVER_PORT} \
  -Dsentinel.dashboard.auth.username=${SENTINEL_DASHBOARD_AUTH_USERNAME} \
  -Dsentinel.dashboard.auth.password=${SENTINEL_DASHBOARD_AUTH_PASSWORD} \
  -jar sentinel-dashboard.jar"]
