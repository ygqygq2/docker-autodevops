#!/bin/bash

set -e

# 有接 $1 参数则安装 node，否则只安装 nvm
NVM_DIR=${NVM_DIR:-"/root/.nvm"}
TO_INSTALL=${1}

# 安装 NVM
mkdir -p $NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash -x
echo "Installed NVM"

# 加载 NVM
source $NVM_DIR/nvm.sh

# 如果有指定 Node.js 版本，则安装
if [ -n "$TO_INSTALL" ]; then
  for version in $(echo $TO_INSTALL | tr "," "\n"); do
    nvm install $version
  done

  # 清理 NVM 缓存
  rm -rf $NVM_DIR/.cache

  echo "Node.js versions installed: $(nvm ls)"
else
  echo "NVM installed, but no Node.js version specified."
fi
