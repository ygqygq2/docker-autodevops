#!/bin/bash

NVM_DIR=${NVM_DIR:-"/root/.nvm"}
TO_INSTALL=${1:-"--lts"}

# 安装 NVM
mkdir -p $NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash -x
echo "Installed NVM"

# 安装指定版本的 Node.js
source $NVM_DIR/nvm.sh
for version in $(echo $TO_INSTALL | tr "," "\n"); do
  nvm install $version
done
