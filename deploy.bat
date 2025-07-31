@echo off

:: 微软漏洞补丁批量下载工具Windows部署脚本
:: 适用于Windows 10及以上版本

:: 检查是否以管理员身份运行
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo 请以管理员身份运行此脚本
    pause
    exit /b 1
)

:: 安装Chocolatey包管理器
echo 安装Chocolatey包管理器...
powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

:: 安装必要依赖
echo 安装必要依赖...
choco install -y git docker-desktop python3

:: 启动Docker服务
echo 启动Docker服务...
net start com.docker.service

echo 等待Docker启动...
timeout /t 10 /nobreak

:: 克隆项目代码
echo 克隆项目代码...
if exist "C:\opt\ms-patch-downloader" (
    echo 项目目录已存在，将其删除...
    rd /s /q "C:\opt\ms-patch-downloader"
)
git clone https://github.com/yourusername/ms-patch-downloader.git "C:\opt\ms-patch-downloader"
cd /d "C:\opt\ms-patch-downloader"

:: 配置环境变量
echo 配置环境变量...
copy .env.example .env
:: 生成随机SECRET_KEY
powershell -Command "$secretKey = (-join ((65..90) + (97..122) + (48..57) | Get-Random -Count 32 | ForEach-Object {[char]$_})); (Get-Content .env) -replace 'your-secret-key-here', $secretKey | Set-Content .env"

:: 构建和启动Docker容器
echo 构建和启动Docker容器...
docker-compose build
docker-compose up -d

:: 显示部署成功信息
echo.
部署成功!

echo 应用已部署在Docker容器中，访问地址: http://localhost:5000
echo 默认端口为5000，如果需要修改，请编辑docker-compose.yml文件中的端口映射

echo 以下是容器运行状态:
docker-compose ps

echo.
如需查看应用日志，请运行: docker-compose logs -f

echo.
部署脚本执行完毕。
pause