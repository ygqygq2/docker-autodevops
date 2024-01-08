## 介绍
Some docker for auto devops.

### k8s-alpine
Kubectl & helm docker image

### docker-in-docker
docker in docker, add bash.

### maven
Docker for maven, add bash.

### gcc

### tengine
Docker for tengine

### mysql-exec-sql
Mysql client exec sql file or sql url.

## 利用 Action 自动构建镜像
方法：
1. 创建 [issue](../../issues/new)
2. 标题 : image_dir/Dockerfile:image_tag，如 k8s-alpine/Dockerfile:v1.24.2，其中不写 “/Dockerfile”，则使用默认的 Dockerfile，不写“:tag”，则默认使用日期生成
3. 内容: 环境变量名=环境变量，如 KUBE_VERSION=v1.24.2，一行一个，具体构建参考请查看 Dockerfile
