#!/bin/bash
set -e

# Get Sentinel version
SENTINEL_VER=$(cat /home/sentinel/VERSION 2>/dev/null || echo 'unknown')

# Get Java version
JAVA_VER=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}' | cut -d'.' -f1)

# Auto-add --add-opens for JDK 9+ with old Sentinel versions (< 1.8.6)
# Sentinel >= 1.8.6 uses Spring Boot 2.3.x which supports Java modules, no need for --add-opens
EXTRA_OPTS=""
if [ "${JAVA_VER}" -ge 9 ]; then
  # Extract version number, remove 'v' prefix if present
  SENTINEL_VER_NUM=$(echo "${SENTINEL_VER}" | sed 's/^v//')
  
  # Compare version (1.8.6 = 1*10000 + 8*100 + 6 = 10806)
  SENTINEL_VER_MAJOR=$(echo "${SENTINEL_VER_NUM}" | cut -d'.' -f1)
  SENTINEL_VER_MINOR=$(echo "${SENTINEL_VER_NUM}" | cut -d'.' -f2)
  SENTINEL_VER_PATCH=$(echo "${SENTINEL_VER_NUM}" | cut -d'.' -f3)
  
  # Default to 0 if not set
  SENTINEL_VER_MAJOR=${SENTINEL_VER_MAJOR:-1}
  SENTINEL_VER_MINOR=${SENTINEL_VER_MINOR:-8}
  SENTINEL_VER_PATCH=${SENTINEL_VER_PATCH:-0}
  
  SENTINEL_VER_CODE=$((SENTINEL_VER_MAJOR * 10000 + SENTINEL_VER_MINOR * 100 + SENTINEL_VER_PATCH))
  
  # Only add --add-opens for Sentinel < 1.8.6 (version code < 10806)
  if [ "${SENTINEL_VER_CODE}" -lt 10806 ]; then
    EXTRA_OPTS="--add-opens=java.base/java.lang=ALL-UNNAMED"
  fi
fi

echo "========================================="
echo "Sentinel Dashboard Startup"
echo "========================================="
echo "Sentinel Version: ${SENTINEL_VER}"
echo "Java Version: ${JAVA_VER}"
echo "Server Port: ${SENTINEL_DASHBOARD_SERVER_PORT}"
echo "Auth Username: ${SENTINEL_DASHBOARD_AUTH_USERNAME}"
echo "JVM Options: ${JAVA_OPTS}"
echo "Extra Options: ${EXTRA_OPTS}"
echo "========================================="

# Start Sentinel Dashboard
exec java ${JAVA_OPTS} ${EXTRA_OPTS} \
  -Dserver.port=${SENTINEL_DASHBOARD_SERVER_PORT} \
  -Dsentinel.dashboard.auth.username=${SENTINEL_DASHBOARD_AUTH_USERNAME} \
  -Dsentinel.dashboard.auth.password=${SENTINEL_DASHBOARD_AUTH_PASSWORD} \
  -jar sentinel-dashboard.jar "$@"
