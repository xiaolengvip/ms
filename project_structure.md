# 微软漏洞补丁批量下载工具

## 项目概述
这是一个可以批量获取微软漏洞补丁下载链接地址的Web应用程序，可以部署在Ubuntu服务器上。

## 项目结构
```
ms-patch-downloader/
├── backend/
│   ├── app.py               # 主应用入口
│   ├── requirements.txt     # Python依赖
│   ├── config.py            # 配置文件
│   ├── utils/
│   │   ├── patch_fetcher.py # 漏洞补丁获取工具
│   │   └── link_extractor.py # 链接提取器
│   └── routes/
│       ├── api.py           # API路由
│       └── views.py         # 视图路由
├── frontend/
│   ├── index.html           # 主页面
│   ├── styles/
│   │   └── main.css         # 样式表
│   ├── scripts/
│   │   └── app.js           # 前端逻辑
│   └── assets/              # 静态资源
├── Dockerfile               # Docker部署文件
├── docker-compose.yml       # Docker Compose配置
└── README.md                # 项目说明
```

## 技术栈
- 后端: Python + Flask
- 前端: HTML, CSS, JavaScript
- 部署: Docker, Ubuntu

## 功能模块
1. **补丁信息获取模块**: 从微软官方源获取漏洞补丁信息
2. **链接提取模块**: 从补丁信息中提取下载链接
3. **Web界面模块**: 提供用户交互界面
4. **批量下载模块**: 支持批量下载补丁

## 部署要求
- Ubuntu 20.04+ 
- Python 3.8+ 
- Docker (可选)