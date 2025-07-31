# 微软漏洞补丁批量下载工具

## 项目概述
这是一个可以批量获取微软漏洞补丁下载链接地址的Web应用程序，可以部署在Ubuntu服务器上。该工具通过微软官方API获取漏洞补丁信息，并提供直观的用户界面，方便管理员批量下载和管理补丁。

## 功能特点
- 搜索微软漏洞补丁（按产品、版本、严重程度、日期范围）
- 查看补丁详细信息
- 批量下载补丁
- 下载进度监控
- 支持Docker部署

## 技术栈
- 后端: Python + Flask
- 前端: HTML, CSS, JavaScript
- 部署: Docker, Ubuntu

## 安装和使用
### 本地开发环境
1. 克隆项目
```bash
git clone https://github.com/yourusername/ms-patch-downloader.git
cd ms-patch-downloader
```

2. 创建虚拟环境
```bash
python -m venv venv
# Windows
env\Scripts\activate
# Linux/Mac
source venv/bin/activate
```

3. 安装依赖
```bash
pip install -r requirements.txt
```

4. 设置环境变量
创建`.env`文件:
```
FLASK_APP=app.py
FLASK_ENV=development
SECRET_KEY=your-secret-key-here
DEBUG=True
PORT=5000
```

5. 运行应用
```bash
flask run
```

6. 访问应用
打开浏览器，访问 http://localhost:5000

### Docker部署
1. 构建镜像
```bash
docker-compose build
```

2. 启动容器
```bash
docker-compose up -d
```

3. 访问应用
打开浏览器，访问 http://服务器IP:5000

## 项目结构
```
ms-patch-downloader/
├── app.py               # 主应用入口
├── config.py            # 配置文件
├── requirements.txt     # Python依赖
├── Dockerfile           # Dockerfile
├── docker-compose.yml   # Docker Compose配置
├── README.md            # 项目说明
├── frontend/
│   ├── index.html       # 主页面
│   ├── styles/
│   │   └── main.css     # 样式表
│   └── scripts/
│       └── app.js       # 前端逻辑
├── routes/
│   ├── __init__.py
│   ├── api.py           # API路由
│   └── views.py         # 视图路由
└── utils/
    ├── __init__.py
    ├── patch_fetcher.py # 补丁获取工具
    └── link_extractor.py # 链接提取器
```

## 使用说明
1. 在搜索框中输入搜索条件（产品、版本、严重程度、日期范围）
2. 点击"搜索"按钮获取补丁列表
3. 在结果列表中，可以查看补丁详情或直接下载
4. 也可以选择多个补丁，点击"下载所选"按钮批量下载
5. 下载进度会显示在"下载管理"区域

## 注意事项
1. 该工具仅用于获取微软官方漏洞补丁，请勿用于非法用途
2. 使用前请确保网络连接正常，可以访问微软官方网站
3. 部分补丁可能需要微软账户登录才能下载
4. 部署到生产环境时，请修改SECRET_KEY为安全的随机字符串
5. 建议定期更新应用以获取最新功能和安全修复

## 许可证
本项目采用MIT许可证 - 详情请见LICENSE文件