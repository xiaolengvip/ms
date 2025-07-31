import os

class Config:
    # 基础配置
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'hard-to-guess-string'
    DEBUG = os.environ.get('DEBUG') == 'True'
    PORT = int(os.environ.get('PORT', 5000))

    # 微软补丁相关配置
    MS_PATCH_URL = os.environ.get('MS_PATCH_URL') or 'https://api.msrc.microsoft.com'
    REQUEST_TIMEOUT = int(os.environ.get('REQUEST_TIMEOUT', 30))

    # 缓存配置
    CACHE_TYPE = 'simple'
    CACHE_DEFAULT_TIMEOUT = int(os.environ.get('CACHE_TIMEOUT', 3600))

class DevelopmentConfig(Config):
    DEBUG = True

class ProductionConfig(Config):
    DEBUG = False

# 根据环境变量选择配置
config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'default': DevelopmentConfig
}