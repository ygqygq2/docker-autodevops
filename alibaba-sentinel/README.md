# Alibaba Sentinel Dashboard Docker Image

基于 [Alibaba Sentinel](https://github.com/alibaba/Sentinel) 构建的控制台 Docker 镜像。

## 快速开始

### 构建镜像

```bash
docker build -t sentinel-dashboard:1.8.9 .
```

### 运行容器

```bash
docker run -d --name sentinel-dashboard \
  -p 8080:8080 \
  sentinel-dashboard:1.8.9
```

访问 `http://localhost:8080`，使用默认账号 `sentinel/sentinel` 登录。

## 构建参数

| 参数               | 默认值 | 说明          |
| ------------------ | ------ | ------------- |
| `JAVA_VERSION`     | 17     | JDK 版本      |
| `SENTINEL_VERSION` | 1.8.9  | Sentinel 版本 |

示例：

```bash
# 使用 JDK 21 构建
docker build --build-arg JAVA_VERSION=21 -t sentinel-dashboard:1.8.9 .

# 使用指定 Sentinel 版本构建
docker build --build-arg SENTINEL_VERSION=1.8.8 -t sentinel-dashboard:1.8.8 .
```

## 环境变量

| 变量                               | 默认值              | 说明       |
| ---------------------------------- | ------------------- | ---------- |
| `JAVA_OPTS`                        | `-Xms256m -Xmx512m` | JVM 参数   |
| `SENTINEL_DASHBOARD_AUTH_USERNAME` | sentinel            | 登录用户名 |
| `SENTINEL_DASHBOARD_AUTH_PASSWORD` | sentinel            | 登录密码   |
| `SENTINEL_DASHBOARD_SERVER_PORT`   | 8080                | 服务端口   |

示例：

```bash
docker run -d --name sentinel-dashboard \
  -p 8080:8080 \
  -e JAVA_OPTS="-Xms512m -Xmx1g" \
  -e SENTINEL_DASHBOARD_AUTH_USERNAME=admin \
  -e SENTINEL_DASHBOARD_AUTH_PASSWORD=admin123 \
  sentinel-dashboard:1.8.9
```

## 调试模式

镜像支持自定义命令，方便调试：

```bash
# 进入 shell
docker run -it --rm sentinel-dashboard:1.8.9 sh

# 查看文件
docker run -it --rm sentinel-dashboard:1.8.9 ls -la

# 自定义 Java 参数启动
docker run -d -p 8080:8080 sentinel-dashboard:1.8.9 \
  java -Xms512m -Xmx1g -Dserver.port=8080 -jar sentinel-dashboard.jar
```

## 客户端接入

在 Spring Boot 应用中添加依赖：

```xml
<dependency>
  <groupId>com.alibaba.csp</groupId>
  <artifactId>sentinel-transport-simple-http</artifactId>
  <version>1.8.9</version>
</dependency>
```

配置 JVM 参数：

```bash
-Dcsp.sentinel.dashboard.server=localhost:8080
-Dproject.name=your-application-name
```

> **注意**: Dashboard 使用 JDK 17，客户端应用可以使用 JDK 8+，两者通过 HTTP 通信，互不影响。

## 相关链接

- [Sentinel GitHub](https://github.com/alibaba/Sentinel)
- [Sentinel 官方文档](https://sentinelguard.io/zh-cn/docs/introduction.html)
- [Sentinel Dashboard 文档](https://sentinelguard.io/zh-cn/docs/dashboard.html)
