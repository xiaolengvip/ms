from flask import Flask
from flask_cors import CORS
import os
from dotenv import load_dotenv

# 加载环境变量
load_dotenv()

# 创建Flask应用实例
app = Flask(__name__)
CORS(app)  # 允许跨域请求

# 加载配置
app.config.from_object('config.Config')

# 注册蓝图
from routes.api import api_bp
from routes.views import views_bp

app.register_blueprint(api_bp, url_prefix='/api')
app.register_blueprint(views_bp)

# 启动应用
if __name__ == '__main__':
    # 开发环境下使用debug模式
    debug_mode = os.environ.get('DEBUG', 'True') == 'True'
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 5000)), debug=debug_mode)