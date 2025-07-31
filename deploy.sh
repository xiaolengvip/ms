#!/bin/bash

# 微软漏洞补丁批量下载工具一键部署脚本
# 适用于Ubuntu 20.04及以上版本

# 确保以root用户运行
if [ "$EUID" -ne 0 ]
  then echo "请以root用户运行此脚本"
  exit
fi

# 更新系统包
echo "更新系统包..."
apt update && apt upgrade -y

# 安装必要依赖
echo "安装必要依赖..."
apt install -y git curl wget

# 安装Docker
echo "安装Docker..."
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update
apt install -y docker-ce

# 安装Docker Compose
echo "安装Docker Compose..."
curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d'"' -f4)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# 克隆项目代码
echo "克隆项目代码..."
if [ -d "/opt/ms-patch-downloader" ]; then
  echo "项目目录已存在，将其删除..."
  rm -rf /opt/ms-patch-downloader
fi
git clone https://github.com/yourusername/ms-patch-downloader.git /opt/ms-patch-downloader
cd /opt/ms-patch-downloader

# 配置环境变量
echo "配置环境变量..."
cp .env.example .env
# 生成随机SECRET_KEY
SECRET_KEY=$(openssl rand -hex 32)
sed -i "s/your-secret-key-here/$SECRET_KEY/g" .env

# 构建和启动Docker容器
echo "构建和启动Docker容器..."
docker-compose build
docker-compose up -d

# 显示部署成功信息
echo "\n部署成功!\n"
echo "应用已部署在Docker容器中，访问地址: http://服务器IP:5000"
echo "默认端口为5000，如果需要修改，请编辑docker-compose.yml文件中的端口映射"
echo "\n以下是容器运行状态:"
docker-compose ps

# 提示如何查看日志
echo "\n如需查看应用日志，请运行: docker-compose logs -f"

# 完成
echo "\n部署脚本执行完毕。"